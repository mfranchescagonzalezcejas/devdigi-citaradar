import pytest

from citaradar.domain import (
    Channel,
    ChannelDecisionError,
    NoChannelAvailable,
    Office,
    PreferenceRequired,
    decide_channel,
    office_matches,
)


@pytest.mark.parametrize("only", [Channel.IN_PERSON, Channel.PHONE])
def test_single_option_selected_automatically(only):
    assert decide_channel([only]) == only
    assert decide_channel([only], preference=Channel.PHONE if only == Channel.IN_PERSON else Channel.IN_PERSON) == only

def test_two_options_require_user_choice():
    with pytest.raises(PreferenceRequired):
        decide_channel([Channel.IN_PERSON, Channel.PHONE])
    assert decide_channel([Channel.IN_PERSON, Channel.PHONE], Channel.PHONE) == Channel.PHONE

def test_zero_channels_is_blocked():
    with pytest.raises(NoChannelAvailable):
        decide_channel([])

def test_wrong_preference_is_rejected():
    with pytest.raises(ChannelDecisionError):
        decide_channel([Channel.IN_PERSON, Channel.PHONE], "unsupported")

def test_city_not_province():
    allow = {"Barcelona"}
    assert office_matches(Office("Oficina Barcelona","Barcelona","2026-11-03T10:00"),allow)
    assert not office_matches(Office("Terrassa","Terrassa","2026-11-03T10:00"),allow)
    assert not office_matches(Office("Oficina unknown",None,"2026-11-03T10:00"),allow)
    assert not office_matches(Office("Barcelona sin huecos","Barcelona",None),allow)
