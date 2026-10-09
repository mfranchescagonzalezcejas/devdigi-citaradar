# Architecture / state-machine contract

`Desktop UI (PySide6)` -> `Browser service (Playwright)` -> `SEPE page adapter` -> `Channel discovery` -> `Availability parser` -> `Municipality filter` -> `Notifications / explicit human confirmation`.

States: `WAIT_LOGIN`, `POSTAL_CODE`, `OFFICE_TYPE`, `PROCEDURE`, `SUBPROCEDURE`, `DOCUMENT_ID`, `CHANNEL_DISCOVERY`, `PREFERENCE_REQUIRED`, `RESULTS_LOADING`, `NO_AVAILABILITY`, `MATCH_FOUND`, `SESSION_EXPIRED`, `ERROR`, `PAUSED`.

Critical contract:

- `choose_channel(channels, preference=None)` never invents an option. One valid channel -> select automatically; two -> require preference; zero -> blocked. A saved preference is considered **only when two channels are actually available**; it must not override sole available channel.
- `refresh_channel` (mechanism) and `target_channel` (matching criterion) are distinct concepts.
- Passive DOM evidence of a refresh is required; a visible page with unchanged content may represent a completed refresh, so timestamps/loading state or response events must be used to distinguish. Timeouts are not availability results.
- If a single channel is offered, do not click the same option repeatedly expecting a refresh.
- An office match requires trustworthy municipality identity; ambiguous office metadata must not silently match Barcelona.
- Do not persist browser session cookies outside app-owned private local profile; never commit profiles.
- The browser remains visible and booking remains manual.

No live Playwright script included until SEPE markup and monitoring permission have been validated.
