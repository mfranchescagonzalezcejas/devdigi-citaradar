"""Validate canonical BDD specifications; does not execute feature steps."""

import json
import re
from collections import Counter
from pathlib import Path

import pytest
from gherkin.parser import Parser

ROOT = Path(__file__).resolve().parents[1]
FEATURES = ROOT / "features"
MANIFEST = ROOT / "planning" / "bdd-manifest.json"
EXPECTED_FILES = {
    "canales.feature",
    "e2e-portal-simulado.feature",
    "formulario-sepe.feature",
    "monitorizacion.feature",
    "oficinas.feature",
    "seguridad.feature",
}


@pytest.mark.parametrize("name", sorted(EXPECTED_FILES))
def test_feature_parses_as_gherkin(name):
    source = (FEATURES / name).read_text(encoding="utf-8")
    assert "Synthetic portal only" in source
    feature = Parser().parse(source)["feature"]
    assert feature["name"]
    assert feature["children"]


def test_all_jira_scenarios_match_canonical_manifest():
    data = json.loads(MANIFEST.read_text(encoding="utf-8"))
    planned = {case["key"]: case for case in data["cases"]}
    assert len(planned) == 26 == len(data["cases"])
    assert set(planned) == {f"CITA-{i}" for i in range(104, 130)}
    assert {path.name for path in FEATURES.glob("*.feature")} == EXPECTED_FILES

    found = {}
    suite_counts = Counter()
    for path in sorted(FEATURES.glob("*.feature")):
        feature = Parser().parse(path.read_text(encoding="utf-8"))["feature"]
        for child in feature["children"]:
            scenario = child.get("scenario")
            assert scenario is not None, f"Unexpected feature child in {path.name}"
            tags = [tag["name"] for tag in scenario["tags"]]
            keys = [tag[1:] for tag in tags if re.fullmatch(r"@CITA-\d+", tag)]
            assert len(keys) == 1, (path.name, scenario["name"], tags)
            key = keys[0]
            assert key not in found, f"Duplicate Jira scenario: {key}"
            assert key in planned, f"Unexpected Jira scenario: {key}"
            case = planned[key]
            assert scenario["name"] == case["title"], key
            assert f"@{case['id']}" in tags, key
            expected_tag = "@smoke" if case["suite"] == "Smoke" else "@regression"
            assert expected_tag in tags, key
            assert ("@smoke" in tags) != ("@regression" in tags), key
            assert case["feature"] == path.relative_to(ROOT).as_posix(), key
            assert scenario["steps"], key
            assert case["automation"] == "not_implemented", key
            found[key] = scenario["name"]
            suite_counts[case["suite"]] += 1

    assert set(found) == set(planned)
    assert suite_counts == Counter({"Smoke": 12, "Regression": 14})


def test_pytest_bdd_dependency_is_available():
    import pytest_bdd

    assert pytest_bdd is not None
