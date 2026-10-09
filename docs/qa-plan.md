# QA / BDD v0.1.0 — CitaRadar

- Existing AgileTest suite **CitaRadar v0.1 — Smoke**: 12 Test Cases.
- Existing AgileTest suite **CitaRadar v0.1 — Regression**: 14 Test Cases.
- Test Plan **CITA-73**: 26 Test Cases; planned Smoke execution **CITA-74**
  and planned Regression execution **CITA-75** (no PASS results claimed).
- Existing Jira Test Cases **CITA-104 through CITA-129**. Do not import
  duplicate test cases or reuse historical execution results.
- Six canonical Gherkin source files: `features/*.feature`.
- Source-to-Jira manifest: `planning/bdd-manifest.json`.
- WU0 (`CITA-130`) checks only parseability and traceability, **not** the
  actual behavioral steps. See `docs/bdd.md` for automation status.

## Acceptance and safety

- Smoke/Regression must eventually run against deterministic offline
  fixtures and a local synthetic portal; never live SEPE in CI.
- Require Jenkins PR merge gate, preserve merge-commit-only flow.
- Acceptance needs recorded QA evidence, no unaccepted blockers and
  no sensitive identifiers, credentials or browser profiles in artifacts.
- Portal checks, if ever permitted, need explicit supervised user approval.
