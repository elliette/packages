# Analyze CI Failure Scripts

This directory contains Dart scripts for interacting with LUCI/Buildbucket to analyze CI failures and flakes in `flutter/packages`.

No credentials or LUCI access are needed. Flutter's builds and logs are public, and the scripts make only unauthenticated requests to Buildbucket, LogDog and the GitHub API.

## Setup

Run the scripts from the repository root through `run.sh`, which fetches
dependencies on first use:

```bash
script/analyze_ci_failure/run.sh <script> [args...]
```

`run.sh` uses the Dart SDK bundled with Flutter directly rather than Flutter's
`dart` wrapper, so several scripts can run in parallel without waiting on
Flutter's startup lock.

## Common Features

- **Caching**: All scripts cache network responses under `$TMPDIR/ci_analysis_cache` (or the directory specified by the `CI_ANALYSIS_CACHE` environment variable) to speed up repeated runs.

## Development

Shared logic lives in `lib/` and is unit tested. CI runs the same checks
(see `.ci/scripts/analyze_ci_failure_*.sh`):

```bash
cd script/analyze_ci_failure
dart analyze --fatal-infos
dart format --set-exit-if-changed .
dart test
```

## Scripts

### `bin/find_builds.dart`

Finds LUCI builds for a given Pull Request or commit SHA.

**Usage:**
```bash
script/analyze_ci_failure/run.sh find_builds [options]
```

**Options:**
- `--pr`: GitHub PR number (presubmit tryjobs).
- `--commit`: Full commit SHA (postsubmit builds).
- `--repo`: Repository `owner/name` (defaults to `flutter/packages`).
- `--project`: LUCI project (defaults to `flutter`).
- `--limit`: Max builds to retrieve (defaults to `400`).
- `--[no-]failed-only`: Only show non-successful builds.
- `--[no-]json`: Output as JSON.

---

### `bin/summarize_failures.dart`

Condenses failure logs from one or more Buildbucket IDs.

**Usage:**
```bash
script/analyze_ci_failure/run.sh summarize_failures <build_id> [<build_id> ...] [options]
```

**Options:**
- `--max-lines`: Signature lines to keep per step (defaults to `12`).
- `--[no-]json`: Output as JSON.
