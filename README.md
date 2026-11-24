# Homework 5 — Modular Shopping Cart

Build the architecture behind a small macOS shopping app. The supplied package contains a SwiftUI shell and three modules: `CartDomain`, `CatalogData`, and `ShoppingApp`. Implement the published interfaces and behavior, and correct the target dependencies in `Package.swift`.

The assignment is individual and worth **12 base points plus 4 optional bonus points**. [TASKS_AND_GRADES.md](TASKS_AND_GRADES.md) contains the complete public contract, grading categories, and exact point allocation. The starter intentionally omits two target dependencies, so it does not initially build; its example tests then fail until you implement the behavior.

## Local workflow

Requires a Mac with Xcode's Swift toolchain and macOS 13 or later. From the repository root:

```sh
swift test
swift run ShopDemo
```

The tests do not require network access. `swift test` is the verification command; CI runs it on a clean macOS runner. `swift run ShopDemo` launches the supplied app shell for exploration; UI appearance is not graded. Keep the provided public declarations and `ArchitectureTests` target, and add your own tests as appropriate. You may add private implementation types and functions.

Complete `PLAN.md` and `AGENT_WORKLOG.md`. Keep selected non-sensitive agent artifacts in `artifacts/` if helpful; no minimum artifact count applies. Automatic grading checks only that the plan and worklog exist and contain at least one byte. Students remain accountable for documenting actual agent use.

Create an individual public repository from this template. Commit your work and follow [SUBMISSION.md](SUBMISSION.md) to submit its URL and the exact commit SHA.
