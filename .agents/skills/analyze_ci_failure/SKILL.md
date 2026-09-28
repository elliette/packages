---
name: analyze_ci_failure
description: >-
  Triage a CI failure on a flutter/packages PR or commit,
  or perform a batch audit of flakes over a time period.
  Fetches the LUCI build logs, determines whether the failure was actually
  caused by the change under test, and if not, proves whether it is a known
  flake by finding prior occurrences of the same failure signature with links.
  Use when the user pastes a red CI log, asks "is this failure related to my
  PR/commit?", asks whether a test is flaky, or is gardening a red tree.
---

# Analyze a CI failure

Answers three questions, in order:

1. **What actually failed?** (which builder, step, package, test)
2. **Did this change cause it?** (compare failing package vs. changed packages)
3. **If not, is it a known flake?** (find prior occurrences, with URLs)

All scripts are Dart scripts located in `script/analyze_ci_failure`. Run them
from the repository root through `script/analyze_ci_failure/run.sh <script>`,
which fetches dependencies on first use. It is safe to run several at once
(e.g. one `summarize_failures` per build): unlike a bare `dart run`, it doesn't
wait on Flutter's startup lock. The scripts cache every network response under
`$TMPDIR/ci_analysis_cache`, so re-running is nearly free.

> [!IMPORTANT]
> Never paste a raw CI log into your context to analyze it. A single
> `native integration tests` log is ~650 lines. `summarize_failures.dart` reduces
> it to ~10 lines and tells you where the full log is cached locally so you can
> `grep` it if you need more.

## Workflow 1: Single Failure Triage

### Step 1 — Find the failing builds

```bash
script/analyze_ci_failure/run.sh find_builds --commit <full-40-char-sha> --failed-only     # landed commit
script/analyze_ci_failure/run.sh find_builds --pr <number> --failed-only                   # open PR
```

Prints every red build with its Milo URL and Buildbucket ID.

> [!NOTE]
> For a landed commit you will often see the **same builder listed 2–3 times**.
> Cocoon auto-retries failed postsubmit builds, and each attempt is its own
> build. This matters for step 3: three consecutive failures of a flaky test is
> unlucky, not proof of a real regression.

### Step 2 — Condense each failure

```bash
script/analyze_ci_failure/run.sh summarize_failures <build_id> [<build_id> ...]
```

For each failing step this reports:

- **`packages with errors`** — the package(s) `flutter_plugin_tools` blamed. This
  is the key input to step 3.
- **`signature`** — the identifying failure lines.
- **`suggested: --match ...`** — a regex to feed to `flake_history.dart`. Copy
  it verbatim. For Dart tests it ends in `\[E\]`; don't drop that, because the
  bare test name is also printed when the test *passes*.
- **`cached log`** — grep this path for detail instead of re-downloading.

> [!IMPORTANT]
> **`INFRA_FAILURE` + "The build was cancelled" is usually a timeout, not
> infra.** When a build hits its execution timeout (~60 min, shown in the
> header), LUCI cancels the running step and then blames a *cleanup* step like
> `reset XCode` or `kill and cleanup avd`, which has no log. The script reports
> the cancelled step as **`HUNG STEP`** with where it stopped (last package,
> last test/benchmark). Treat that as the real failure, and give its
> suggested match to step 4 **with `--timeouts-only`**.

### Step 3 — Is it related to the change?

```bash
script/analyze_ci_failure/run.sh changed_packages --commit <sha> --repo-root "$(git rev-parse --show-toplevel)"
script/analyze_ci_failure/run.sh changed_packages --pr <number>
```

The user will not supply `--repo-root`; fill it in yourself. Use the root of
the user's open `flutter/packages` workspace (a worktree is fine). Only fall
back to omitting it, which leaves `gh`/the GitHub API as the only source, if no
local checkout exists.

The script reports its `mode`, and you should read it:

- **`flutter_plugin_tools (authoritative)`** — it ran
  `flutter_plugin_tools list --run-on-changed-packages --base-sha=<sha>^`, the
  exact code path CI uses to pick packages. Trust this.
- **`heuristic`** — the commit isn't checked out, so package selection was
  reconstructed locally. Good enough to triage, but say so when reporting.

The tool can only be used when the local checkout's **HEAD is the commit being
analyzed**, because `--run-on-changed-packages` always diffs `base-sha..HEAD`.
To upgrade a heuristic answer to an authoritative one, check the commit out
(or `git worktree add` it) and re-run.

Judge relatedness with these rules, strongest signal first:

| Observation | Conclusion |
| --- | --- |
| Output has a **`WARNING: this is a Flutter SDK roll (<channel>)`** | The rules below don't apply. Failures on the **other** channel's builders can't be caused by the roll. Failures on the rolled channel **may** be, in any package → step 4 is mandatory |
| Failing package is **not** in the selected-package list | Very likely unrelated → go to step 4 |
| Output says the change *"could affect the entire repository"* (and it's not a roll) | Tools run against **all** packages, so failures in untouched packages are expected noise → go to step 4 |
| Failing package **is** changed, and the failing test covers the changed code | Likely a real regression → stop and report it |
| Failing package is changed, but the failure is in an unrelated test | Inconclusive → still do step 4 |

> [!WARNING]
> "The PR only touches CI config, so the failure must be unrelated" is a
> *hypothesis*, not a conclusion. Confirm it in step 4 by showing the same
> failure on commits that predate the change. Users frequently arrive already
> believing this — verify it rather than agreeing. This goes double for
> autoroller PRs (`engine-flutter-autoroll`, "Roll Flutter from X to Y"),
> which change only a `.ci/flutter_*.version` file but bring in the full
> contents of a new SDK.

### Step 4 — Is it a known flake?

```bash
script/analyze_ci_failure/run.sh flake_history --builder "<builder name>" --bucket prod \
    --match '<suggested match from step 2>' --scan 300
# For a HUNG STEP, add --timeouts-only (see below).
```

Scan both buckets: `--bucket prod` (postsubmit, slower-moving history) and
`--bucket try` (presubmit, many more runs but ~2 weeks per 600 builds). Also
scan the **other channel's twin builder**. flutter/packages runs most
builders twice, once against `master` and once against `stable`
(`... shard_1 master` and `... shard_1 stable`). A failure on both channels
rules out a channel-specific regression.

**`--timeouts-only`** is required when the match came from a `HUNG STEP`. A
hang's match is just the name of the last test/benchmark, which also appears in
every run that *passed* it. With the flag, only the last lines of cancelled
steps are searched, so only builds that hung **at the same place** count.
Without it, a hang with no history can look like a chronic flake.

Add `--markdown` for a table suitable for an issue or report.

Each build is listed with the change it tested (`PR #1234` for try builds,
`commit 0123abcde` for prod). Use it to check that matches come from
**unrelated PRs** or **commits that predate the change**. A match on the PR
under investigation, or on a later build of the same PR, proves nothing.

If the output starts with **`WARNING: the newest build of this builder is N
days old`**, the builder has been renamed or retired, and its history says
nothing about current CI. Find the current builder name (e.g. from
`find_builds.dart` output for a recent PR) and scan that instead.

Interpretation:

- **Matches on commits predating the change** → conclusively a pre-existing
  flake, not caused by this PR/commit. Report the oldest confirmed occurrence.
- **Zero prior matches** → the failure is *new*. That doesn't prove the change
  caused it. Next steps: check whether the retry passed (`find_builds.dart`
  without `--failed-only`), and for rolls, whether the previous roll PR passed
  the same builder. Report it as "not ruled out" rather than guessing.
- **Some red builds do not match** → the builder has more than one failure mode;
  summarize those separately before concluding.
- **`log purged`** → LogDog only keeps ~6 months. These are *unconfirmed*, not
  *negative*. Never count them as occurrences, and say so when stating how far
  back a flake goes.
- **`log inaccessible`** → LogDog returned HTTP 403. Flutter's logs are public,
  so this is usually transient rate limiting. It's not cached, so re-run later.
  Like purged logs, these are *unconfirmed*, not *negative*.

If the suggested match finds only the original failure, check whether it is too
specific (e.g. names one test when the whole class fails) or too vague (e.g.
matcher output like `Actual: <null>`), and adjust it using the `signature`
lines from step 2.

Also search for an existing issue before calling something untracked:
`gh search issues --repo flutter/flutter "<test name>"`.

### Step 5 — Report

State, in this order:

1. The verdict: caused by the change, or pre-existing flake.
2. The evidence: failing test + the oldest confirmed prior occurrence with URL.
3. How many occurrences, over what window, and how many you personally verified
   vs. inferred. Do not round "20 verified out of 55 red builds" up to "55
   occurrences".
4. What is *not* known (e.g. purged logs, unproven root cause).

---

## Workflow 2: Batch Flake Audit

Use this workflow to survey all failures over a time period or set of commits to identify recurring flakes and trends.

### Step 1 — Identify Commits

Obtain a list of commit SHAs you want to analyze (e.g., all commits in the last week).

```bash
git log --since="YYYY-MM-DD" --until="YYYY-MM-DD" --format="%H"
```

### Step 2 — Batch Find Failures

Iterate over the commits and run `find_builds.dart` to collect all failed builds.

You can automate this with a script or a loop. For each commit, run:

```bash
script/analyze_ci_failure/run.sh find_builds --commit <sha> --failed-only --json
```

Aggregate the JSON outputs to get a list of all failed build IDs and their builders.

### Step 3 — Batch Summarize Failures

For every unique failed build ID found in Step 2, run `summarize_failures.dart` to extract the failure signature.

```bash
script/analyze_ci_failure/run.sh summarize_failures <build_id> --json
```

Group the results by **Signature** or **Failing Package** to identify clusters of identical failures.

### Step 4 — Analyze Clusters and Check History

For each cluster of failures:

1.  Identify the **suggested match** regex.
2.  Run `flake_history.dart` to see how far back this failure goes. As in
    Workflow 1, check both `--bucket prod` and `--bucket try`, and the other
    channel's twin builder.
    ```bash
    script/analyze_ci_failure/run.sh flake_history --builder "<builder>" --bucket prod \
        --match '<regex>' --scan 300
    ```
3.  Check if there is an existing GitHub issue for this signature/test.
    ```bash
    gh search issues --repo flutter/flutter "<test name>"
    ```

### Step 5 — Generate Audit Report

Summarize findings in a table or list, highlighting:
- Recurring flakes (high frequency).
- New flakes (no history).
- Untracked flakes (no GitHub issue).
- Real breakages vs. flakes.
