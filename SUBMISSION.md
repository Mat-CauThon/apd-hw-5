# Submission

Submit exactly these two lines in the course submission channel:

```text
Repository: https://github.com/OWNER/REPOSITORY
Commit: FULL_40_CHARACTER_COMMIT_SHA
```

Replace the placeholders with your individual **public** GitHub repository and the full SHA of the committed submission. Find the SHA by running `git rev-parse HEAD` from your repository after committing. Staff grade that exact commit, not uncommitted files or later changes. Verify `swift test` at that commit and ensure CI runs on the same commit. Do not include credentials, secrets, or private information in the repository or agent artifacts.
