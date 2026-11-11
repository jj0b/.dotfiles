---
name: anthos-pr-review
description: >-
  Rebase, review, and update an Anthos pull request, then run Bugbot and
  that repo's checks. Use when the user invokes /anthos-pr-review with a
  repo (api, ui, infra, amsl) and a pull request number, or asks to review
  and rebase a pull request on anthos-api-v1, anthos-ui-v1, anthos-infra-v1,
  or AMSL.jl.
disable-model-invocation: true
---

# Anthos pull request review

Invoking this skill authorizes commits on the pull request branch, and `git push --force-with-lease` of that branch after a rebase. It does not authorize a force-push of `main` or `master`.

The words after `/anthos-pr-review` are the arguments: a repo, then a pull request number (`api 271`, `anthos-ui-v1 #225`, or a GitHub pull request URL). A branch name is optional. Ignore it and take the head branch from `gh pr view`. If several of these repos are open and no repo was given, ask which one. If the window has a single git root and it is one of the four, a bare number is enough.

| Argument | Repo | Directory |
|---|---|---|
| `api`, `anthos-api-v1` | anthos-api-v1 | `~/Code/Anthos/anthos-api-v1` |
| `ui`, `anthos-ui-v1` | anthos-ui-v1 | `~/Code/Anthos/anthos-ui-v1` |
| `infra`, `anthos-infra-v1` | anthos-infra-v1 | `~/Code/Anthos/anthos-infra-v1` |
| `amsl`, `AMSL.jl` | AMSL.jl | `~/Code/Anthos/AMSL.jl` |

Use the open workspace path when that repo is in the workspace. Work only in that repo.

## Procedure

1. Read the pull request body (`gh pr view <n> --json title,body,headRefName`) and understand what it is trying to do before changing anything.
2. Fetch `origin` and check out the head branch. If checkout would overwrite local changes, stop and ask. Do not stash unless the user confirms.
3. Rebase off of `origin/main` when needed so the pull request has only its own new commits and a clean history. Skip the rebase when `git log origin/main..HEAD` is already exactly those commits. Resolve conflicts in line with the pull request's purpose. After a rebase that rewrote published commits, `git push --force-with-lease` the pull request branch only.
4. Do a pull request review for any issues, and then run Bugbot. Fix any issues found by those, but be careful of scope creep and don't be afraid to push back. Decline a finding that is wrong or outside the pull request's purpose, and say why.
5. Run Bugbot by following the review-bugbot skill. The head branch must already be checked out. After Bugbot returns, fix the real issues. The review-bugbot instruction to stop after findings does not apply here.
6. Run the checks for that repo below. Read and follow that repo's `AGENTS.md` before editing. Run the checks again after fixes, including when the review changed no code, so a failing suite is a finding.
7. Commit fixes on the pull request branch and push. Use `--force-with-lease` only when a rebase rewrote published commits. Update the pull request body when the result no longer matches it.
8. Finish the attribution check below. The pull request is not done until that check is clean and the repo checks have passed.

## Repo checks

**api.** Follow `AGENTS.md`. `make format`, `make lint`, and `make migrate-test` must pass. Run new or modified unit tests. Do not run `make unit-ci`.

**ui.** Follow `AGENTS.md`. Run every command in the Testing section of `.github/pull_request_template.md`, including e2e, using those commands as written. The template is the source of truth for the commands. E2E uses the API on Postgres via `make run-e2e` in anthos-api-v1, then `npm run dev` in anthos-ui-v1, then `npm test` in `anthos-ui-v1/e2e/`. Do not use `make run` for that API.

Components use **semantic** tokens (`bg-card`, `bg-primary`, `text-foreground`, `border-border`), not foundation `--c-*`, and not Tailwind gray utilities. If nothing fits, add a foundation token then a semantic token in `index.css` (and the `@theme inline` mapping if a Tailwind class is needed), then use the class. Do not leave a one-off hex in JSX.

**infra.** Follow `AGENTS.md`. This repo has no test suite. Do not run `pulumi up`. Do not claim a stack was applied.

**amsl.** Follow `AGENTS.md`. Before changing compiler or worker code, read the amsl-development skill it points at. Run `make worker-unit`. When the pull request changes `src/`, also run `make test` and `make coverage` before pushing. If `worker-unit` is cancelled rather than failed, re-run it once before hunting for a cause.

## Cursor attribution

No Cursor attribution anywhere. This is a hard fail, not a preference:
- PR title, PR body, and every commit message must not contain "Made with Cursor", "Generated with Cursor", "Co-authored-by: Cursor", "Co-authored-by Cursor", or any similar Cursor/tool footer.
- Write the PR body yourself (HEREDOC). Do not let `gh pr create` append a footer.
- After the PR exists, run `gh pr view --json body,title` and read the commit messages (`git log`). If any of those strings are present, strip them immediately (`gh pr edit --body-file …`; for an unpushed HEAD commit you authored, amend the message). Do not consider the PR done until they are gone.
