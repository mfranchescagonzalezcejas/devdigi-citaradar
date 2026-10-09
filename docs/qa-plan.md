# QA / BDD v0.1.0 (AgileTest model based on MUSIC)

- Suites: `CitaRadar — Smoke`, `CitaRadar — Sanity`, `CitaRadar — Regression`.
- Release Test Plan: `v0.1.0 — SEPE Desktop PoC QA`.
- Test Executions: `v0.1.0 RC1 — Smoke`, `v0.1.0 RC1 — Regression`.
- 26 authored draft test cases in `planning/qa-agiletest-cases.csv` (offline fixtures only).
- Acceptance: all Smoke and required Regression passed, Jenkins and optional GitHub Actions green, 0 unaccepted blockers, no PII leakage, manual real-portal checks only when approved.
- Traceability: each WU issue links tests, PR, commit/build SHA and QA evidence; do not reuse a historical test execution as a new one.
- E2E fixtures simulate single/both/zero channel choices, procedures with 0/1/many subprocedures, offices in Barcelona vs Terrassa, session expiry, errors and no availability.
- Live SEPE is never contacted by CI.
