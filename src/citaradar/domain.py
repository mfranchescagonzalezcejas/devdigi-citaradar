"""Pure decision rules exercised against synthetic fixtures (no network calls)."""
from dataclasses import dataclass
from enum import Enum

class Channel(str, Enum):
    IN_PERSON = "presencial"
    PHONE = "telefonica"

class ChannelDecisionError(ValueError):
    pass

class PreferenceRequired(ChannelDecisionError):
    pass

class NoChannelAvailable(ChannelDecisionError):
    pass


def decide_channel(available: list[Channel], preference: Channel | None = None) -> Channel:
    """One channel: automatic. Two channels: use explicit user preference."""
    unique = list(dict.fromkeys(available))
    if not unique:
        raise NoChannelAvailable("No enabled appointment channel")
    if len(unique) == 1:
        return unique[0]
    if preference is None:
        raise PreferenceRequired("Ask user which of the available channels to monitor")
    if preference not in unique:
        raise ChannelDecisionError("Preference not in available channels")
    return preference

@dataclass(frozen=True)
class Office:
    name: str
    municipality: str | None
    first_slot: str | None


def office_matches(office: Office, allowed_municipalities: set[str]) -> bool:
    """Unknown municipalities never match; normalize common accents/casing."""
    from unicodedata import normalize
    def norm(s: str) -> str:
        return "".join(c for c in normalize("NFKD", s.casefold()) if not __import__("unicodedata").combining(c)).strip()
    return office.first_slot is not None and office.municipality is not None and (
        norm(office.municipality) in {norm(x) for x in allowed_municipalities}
    )
