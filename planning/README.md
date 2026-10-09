# Jira import notes

- Recommended new Jira Software team-managed project: **CitaRadar**, key `CITA` (if available), Scrum backlog, Epics/Tasks/Bugs plus AgileTest Test Case / Test Plan / Test Execution / Test Script / Test Session.
- `jira-backlog-import.csv`: 10 Epics and 36 Tasks (46 issues). On CSV import map Issue Type, Summary, Description, Priority, Labels. `Epic Group` is a stable staging reference, **not a Jira parent field**: after importing link each `E0x/WUy` task to corresponding epic. Never map it to a Jira issue key.
- `qa-agiletest-cases.csv`: 26 Test Cases intended for AgileTest, and `docs/qa-plan.md` explains the planned Plan / Smoke / Regression / suites. Import columns differ per AgileTest CSV template: adjust to the template offered in your site before submitting. No execution result is claimed.
- AgileTest type activation may require Jira UI/configuration as in DevDigi Music, even if available in existing projects.
- Suggested version: `v0.1.0 — SEPE Desktop PoC` and Sprint 1 only for current deliverables; do not mark any draft work complete.
- No issues have been created in `MUSIC` or `INK`.
