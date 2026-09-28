// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

/// Host of the Buildbucket pRPC API.
const String buildbucketHost = 'cr-buildbucket.appspot.com';

/// Host of the LogDog log server.
const String logdogHost = 'logs.chromium.org';

/// Host of the Milo build UI.
const String miloHost = 'ci.chromium.org';

/// GitHub repo -> the gitiles mirror used in postsubmit `buildset` tags.
const Map<String, List<String>> gitilesMirrors = <String, List<String>>{
  'flutter/packages': <String>['flutter.googlesource.com', 'mirrors/packages'],
  'flutter/cocoon': <String>['flutter.googlesource.com', 'mirrors/cocoon'],
};

/// The repository analyzed when `--repo` is not given.
const String defaultRepo = 'flutter/packages';

/// Sentinel stored in place of a log that LogDog no longer has.
const String logMissing = '__LOG_PURGED__';

/// Sentinel returned (never cached) when LogDog refuses access to a log.
const String logInaccessible = '__LOG_INACCESSIBLE__';

/// Returns [text] cut to at most [maxLength] characters.
String truncate(String text, int maxLength) =>
    text.length <= maxLength ? text : text.substring(0, maxLength);

/// Directory holding cached network responses.
String get cacheDir {
  final Map<String, String> env = Platform.environment;
  return env['CI_ANALYSIS_CACHE'] ?? p.join(env['TMPDIR'] ?? '/tmp', 'ci_analysis_cache');
}

String _cachePath(String kind, String key) {
  final String digest = sha256.convert(utf8.encode(key)).toString().substring(0, 24);
  final String directory = p.join(cacheDir, kind);
  Directory(directory).createSync(recursive: true);
  return p.join(directory, digest);
}

String? _readCache(String kind, String key, Duration? maxAge) {
  final file = File(_cachePath(kind, key));
  if (!file.existsSync()) {
    return null;
  }
  if (maxAge != null) {
    final Duration age = DateTime.now().difference(file.lastModifiedSync());
    if (age > maxAge) {
      return null;
    }
  }
  return file.readAsStringSync();
}

void _writeCache(String kind, String key, String value) {
  // Write-then-rename so that a concurrent run never reads a partial file.
  final String path = _cachePath(kind, key);
  final temp = File('$path.$pid.tmp');
  temp.writeAsStringSync(value);
  temp.renameSync(path);
}

/// Writes a diagnostic message to stderr, keeping stdout machine-readable.
void log(String message) {
  stderr.writeln(message);
}

/// Calls the Buildbucket `buildbucket.v2.Builds/<method>` pRPC endpoint.
///
/// Network errors and 5xx responses are retried; other failures are not,
/// since e.g. a misspelled builder name will never succeed.
Future<Map<String, dynamic>> prpc(
  String method,
  Map<String, dynamic> payload, {
  Duration? cacheAge = const Duration(minutes: 5),
}) async {
  final String body = jsonEncode(payload);
  final cacheKey = '$method:$body';

  if (cacheAge != null) {
    final String? cached = _readCache('prpc', cacheKey, cacheAge);
    if (cached != null) {
      return jsonDecode(cached) as Map<String, dynamic>;
    }
  }

  final url = Uri.https(buildbucketHost, '/prpc/buildbucket.v2.Builds/$method');
  const maxAttempts = 3;
  Object? lastError;
  for (var attempt = 0; attempt < maxAttempts; attempt++) {
    if (attempt > 0) {
      await Future<void>.delayed(Duration(seconds: 1 + (attempt - 1) * 2));
    }

    final http.Response response;
    try {
      response = await http.post(
        url,
        headers: const <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );
    } on Exception catch (e) {
      lastError = e;
      continue;
    }

    if (response.statusCode >= 500) {
      lastError = 'HTTP ${response.statusCode}: ${response.body}';
      continue;
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Buildbucket $method failed with status ${response.statusCode}: '
        '${response.body}',
      );
    }

    // pRPC prefixes JSON responses with the XSSI guard `)]}'`.
    final String raw = response.body;
    final int brace = raw.indexOf('{');
    if (brace == -1) {
      throw Exception('Unexpected Buildbucket response: ${truncate(raw, 200)}');
    }
    final String decoded = raw.substring(brace);
    if (cacheAge != null) {
      _writeCache('prpc', cacheKey, decoded);
    }
    return jsonDecode(decoded) as Map<String, dynamic>;
  }
  throw Exception('Buildbucket $method failed after $maxAttempts attempts: $lastError');
}

/// Pages through `SearchBuilds` until [limit] builds have been collected.
Future<List<Map<String, dynamic>>> searchBuilds(
  Map<String, dynamic> predicate, {
  required String fields,
  int limit = 100,
  Duration? cacheAge = const Duration(minutes: 5),
}) async {
  final collected = <Map<String, dynamic>>[];
  String? pageToken;

  while (collected.length < limit) {
    final payload = <String, dynamic>{
      'predicate': predicate,
      'pageSize': (limit - collected.length).clamp(1, 300),
      'fields': fields,
      'pageToken': ?pageToken,
    };

    final Map<String, dynamic> response = await prpc('SearchBuilds', payload, cacheAge: cacheAge);
    final List<Map<String, dynamic>> builds =
        (response['builds'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
        <Map<String, dynamic>>[];
    if (builds.isEmpty) {
      break;
    }

    collected.addAll(builds);
    pageToken = response['nextPageToken'] as String?;
    if (pageToken == null) {
      break;
    }
  }

  return collected.take(limit).toList();
}

/// Fetches a single build by Buildbucket ID.
Future<Map<String, dynamic>> getBuild(
  String buildId,
  String fields, {
  Duration? cacheAge = const Duration(hours: 1),
}) async {
  return prpc('GetBuild', <String, dynamic>{'id': buildId, 'fields': fields}, cacheAge: cacheAge);
}

/// Constructs the raw LogDog URL for [stepName]'s [logName] log.
String stepLogUrl(String buildId, String stepName, {String logName = 'stdout'}) {
  // LUCI derives URL segments from step names by splitting on `|` and replacing
  // every non-alphanumeric character with `_` (e.g. `process logs (6)` becomes
  // `process_logs__6_`).
  final String segments = stepName
      .split('|')
      .map((String part) => part.replaceAll(RegExp('[^A-Za-z0-9]'), '_'))
      .join('/');

  return 'https://$logdogHost/logs/flutter/buildbucket/cr-buildbucket/'
      '$buildId/+/u/$segments/$logName?format=raw';
}

String _normalizeLogUrl(String url) {
  if (url.endsWith('format=raw')) {
    return url;
  }
  return '$url${url.contains('?') ? '&' : '?'}format=raw';
}

/// Path at which the log for [url] is (or will be) cached.
String logCachePath(String url) {
  return _cachePath('log', _normalizeLogUrl(url));
}

/// Fetches a raw LogDog log, returning [logMissing] if it no longer exists.
Future<String> fetchLog(String url, {Duration? cacheAge}) async {
  url = _normalizeLogUrl(url);
  final String? cached = _readCache('log', url, cacheAge);
  if (cached != null) {
    return cached;
  }

  final http.Response response;
  try {
    response = await http.get(Uri.parse(url));
  } on Exception catch (e) {
    throw Exception('Failed to fetch $url: $e');
  }

  switch (response.statusCode) {
    case 200:
      String text = response.body;
      // LogDog keeps logs for roughly six months. Older streams come back as a
      // 200 whose body is an error message rather than as a 404.
      if (truncate(text, 400).contains('stream path not found') ||
          text.startsWith('ERROR: start fetch')) {
        text = logMissing;
      }
      _writeCache('log', url, text);
      return text;
    case 404:
      _writeCache('log', url, logMissing);
      return logMissing;
    case 403:
      // Not cached: this can be a transient auth or rate-limit error.
      return logInaccessible;
    default:
      throw Exception('Failed to fetch $url: HTTP ${response.statusCode}');
  }
}

/// Milo URL for a single build.
String miloBuildUrl(String project, String bucket, String builder, int? number, String buildId) {
  if (number != null) {
    final String builderPath = Uri.encodeComponent(builder);
    return 'https://$miloHost/ui/p/$project/builders/$bucket/$builderPath/'
        '$number/overview';
  }
  return 'https://$miloHost/b/$buildId';
}

/// Milo URL for a builder's history page.
String miloBuilderUrl(String project, String bucket, String builder) {
  return 'https://$miloHost/ui/p/$project/builders/$bucket/'
      '${Uri.encodeComponent(builder)}';
}

/// The `buildset` tag value that postsubmit builds of [sha] carry.
String commitBuildset(String sha, {String repo = defaultRepo}) {
  final List<String>? mirror = gitilesMirrors[repo];
  if (mirror == null) {
    throw Exception('Unknown repo $repo. Known: ${gitilesMirrors.keys.join(', ')}.');
  }
  return 'commit/gitiles/${mirror[0]}/${mirror[1]}/+/$sha';
}

/// The `github_link` tag value that presubmit builds of PR [pr] carry.
String githubLink(int pr, {String repo = defaultRepo}) {
  return 'https://github.com/$repo/pull/$pr';
}
