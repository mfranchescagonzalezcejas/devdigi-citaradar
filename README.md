# CitaRadar

Open-source Linux-first desktop app for **assisted** monitoring of public-administration appointment availability. First provider: SEPE (Spain). Work in progress: no live SEPE automation is included in this starter.

**Status:** project starter / QA planning. No user credentials, passwords, session cookies, real NIF/NIE, or site screenshots with identity data are shipped here.

## Intended user flow

1. Open CitaRadar; app launches its own **visible browser** (no browser extension).
2. User signs in manually in the official SEPE portal.
3. CitaRadar fills locally configured post code, office type, procedure, conditional subprocedure and identity document.
4. At the map/office step, the app **inspects real enabled channel options before asking for a preference**:
   - 1 channel: select automatically; **do not ask**.
   - 2 channels: ask the user once for the target channel; remember choice for the profile.
   - 0 channels: pause with clear error.
5. Read office results; verify desired **municipality of Barcelona** (not Barcelona province). Discard Terrassa/Sabadell etc.
6. Notify, pause and keep the page open on a match; **the user completes the booking**.

## Safety and scope

- No auto booking, bypassing CAPTCHA/access controls, secret autofill or high-frequency polling.
- Check portal terms and legitimate rate limits **before** enabling actual repeated queries. The default starter makes zero SEPE requests.
- All automated tests use a simulated portal, not production SEPE.
- Store NIF/NIE only in an OS credential store, or keep it in process memory; never in public profile exports, logs or crash reports.
- Logging and CI fixtures use fictitious identifiers only.
- n8n is **optional**, not required for use on the Victus.

## Tooling

Python 3.12+, PySide6, Playwright (visible Chromium), pytest, ruff, mypy, Jenkins (required), optional GitHub Actions. Install actual browser/runtime dependencies when application code is implemented.

## Development gates (modeled on DevDigi Music)

`main` and `develop` protected; merge commits only; no direct pushes to protected branches. Each work unit targets fewer than 1,000 changed lines; CI & acceptance/QA evidence in every PR. Jenkins is the primary gate. Issues/AgileTest in Jira and code/CI evidence in GitHub.

## Starter checks

```bash
python -m pip install -e '.[dev]'
python -m pytest -q
python -m ruff check .
```

See `planning/`, `docs/`, `Jenkinsfile`. The CSVs are an **import preparation**: they are not yet created as Jira tickets until a dedicated Jira Software project exists. Map epics to child tasks after import; QA CSV requires matching to your AgileTest importer format.

## License

MIT license in `LICENSE`. Please review before publication.
