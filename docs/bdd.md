# CitaRadar — BDD contracts (CITA-130)

## State: specifications only, NOT end-to-end automation

Six existing canonical Cucumber/Gherkin files from the audited CitaRadar export
are versioned in `features/`: **26 scenarios, 12 Smoke and 14 Regression**.
The Jira Test Cases already exist as **CITA-104 ... CITA-129**. Do **not**
reimport these `.feature` files into AgileTest to create new Test Cases.

`planning/bdd-manifest.json` is the one-to-one mapping of canonical Jira keys,
functional IDs, feature filenames and planned suites. All entries start with
`automation: not_implemented` on purpose. The QA execution results remain
**unexecuted** until their corresponding step definitions, offline fixtures,
and valid evidence exist. Running the contract checks does not mark a test
case as passed in AgileTest.

## Checks in this work unit

- `pip install -e '.[dev]'` installs `pytest-bdd` and the Gherkin parser.
- `pytest -q` executes existing unit tests and a **contract validator** that
  parses six `.feature` files and checks the 26 canonical Jira mappings.
- No `@scenario()` or `scenarios()` registration is added in this WU.
  Therefore **0 of the 26 scenarios are executed as behavior tests**.
- Ruff and Jenkins remain mandatory; there is no network use by test code.

## Later implementation

- CITA-36: offline synthetic SEPE portal fixture.
- CITA-37: channel matrix / executable step definitions.
- CITA-38: office, geography and failure paths.
- CITA-39: AgileTest membership, plan/execution traceability.
- CITA-40: supervised manual QA if and only if independently approved.

Every implemented scenario needs a real assertion against app behavior,
a deterministic fixture, and a reviewed `pytest-bdd` binding. Avoid fake
passing steps, skipped tests counted as passing, live `sede.sepe.gob.es`
traffic, credentials and personal identity data.

**Source provenance:** canonical audit bundle
`CitaRadar-Gherkin-26-claves-actuales.zip`, corresponding to Jira
CITA-104 through CITA-129. The bundle is a previously generated reference;
it was not a fresh AgileTest export. Reconcile future divergences against
an AgileTest export before changing behavior specifications.
