from datetime import date

import pytest
from click.testing import CliRunner

from google_contacts_birthday_ical_calendar import converter


@pytest.fixture
def example_csv_file():
    csv_file = "tests/fixtures/example.csv"
    with open(csv_file, "r", newline="") as f:
        return f.readlines()


@pytest.fixture
def example_ical_file():
    today = date.today().strftime("%Y%m%d")
    ical = (
        "BEGIN:VCALENDAR\r\n"
        "VERSION:2.0\r\n"
        "PRODID:-//My calendar//Google Contacts Birthday Calendar//\r\n"
        "BEGIN:VEVENT\r\n"
        "SUMMARY:John Doe hat Geburtstag\r\n"
        "DTSTART;VALUE=DATE:19870907\r\n"
        "DTEND;VALUE=DATE:19870908\r\n"
        f"DTSTAMP;VALUE=DATE:{today}\r\n"
        "RRULE:FREQ=YEARLY\r\n"
        "TRANSP:TRANSPARENT\r\n"
        "END:VEVENT\r\n"
        "BEGIN:VEVENT\r\n"
        "SUMMARY:Max Mustermann hat Geburtstag\r\n"
        "DTSTART;VALUE=DATE:19001225\r\n"
        "DTEND;VALUE=DATE:19001226\r\n"
        f"DTSTAMP;VALUE=DATE:{today}\r\n"
        "RRULE:FREQ=YEARLY\r\n"
        "TRANSP:TRANSPARENT\r\n"
        "END:VEVENT\r\n"
        "END:VCALENDAR\r\n"
    )
    return ical


@pytest.fixture()
def cli_runner():
    return CliRunner()


def test_convert_csv_to_ical(example_csv_file, example_ical_file):
    actual_ical_calendar = converter.convert_csv_to_ical(example_csv_file)
    print(actual_ical_calendar)

    assert actual_ical_calendar.decode("utf-8") == example_ical_file


def test_cli_no_parameter(cli_runner):
    actual = cli_runner.invoke(converter.cli, [])
    assert actual.exit_code == 2
    assert "Usage: cli [OPTIONS] CSVFILE ICALFILE" in actual.output
    assert "Error: Missing argument 'CSVFILE'" in actual.output


def test_cli_help(cli_runner):
    actual = cli_runner.invoke(converter.cli, ["--help"])
    assert actual.exit_code == 0
    assert "Usage: cli [OPTIONS] CSVFILE ICALFILE" in actual.output


def test_cli_mandatory_parameter(cli_runner):
    actual = cli_runner.invoke(
        converter.cli, ["tests/fixtures/example.csv",
                        "tests/fixtures/example.ical"])
    assert actual.exit_code == 0
    assert "" in actual.output
