#!/usr/bin/env python
import csv
from datetime import datetime, timedelta, date

import click
from icalendar import Calendar, Event
from loguru import logger


def convert_csv_to_ical(csv_file):
    """Converts column "Name" and "Birthday"
    of CSV dictionary to iCal calendar event"""

    csv_dict = csv.DictReader(csv_file)

    cal = Calendar()
    cal.add("prodid", "-//My calendar//Google Contacts Birthday Calendar//")
    cal.add("version", "2.0")

    for row in csv_dict:
        if len(row["Birthday"]) > 0:
            summary = "{0} hat Geburtstag".format(row["Name"])

            try:
                birthday = datetime.strptime(
                    row["Birthday"], "%Y-%m-%d")
            except ValueError:
                pass

            try:
                birthday = datetime.strptime(
                    row["Birthday"], " --%m-%d")
            except ValueError:
                pass

            logger.debug(
                "Name: {n} - Date: {b}",
                n=row["Name"], b=birthday.date()
            )

            day_after_birthday = birthday
            day_after_birthday += timedelta(days=1)

            event = Event()
            event.add("summary", summary)
            event.add("dtstart", birthday.date())
            event.add("dtend", day_after_birthday.date())
            event.add("dtstamp", date.today())
            event.add("rrule", {"freq": "yearly"})
            event.add("transp", "TRANSPARENT")

            cal.add_component(event)

    return cal.to_ical()


@click.command()
@click.argument("csvfile",
                type=click.File("r"))
@click.argument("icalfile",
                type=click.File("wb"))
@click.option(
    "--verbose",
    is_flag=True,
    help="Enable verbose logging output."
)
def cli(csvfile, icalfile, verbose):
    """Commandline interface for Google Contacts birthday
    to iCal calendar converter

    \b
    CSVFILE is the input .csv filepath.
    ICALFILE is the output .ics filepath.
    """

    logger.disable(__name__)

    if verbose:
        logger.enable(__name__)

    logger.info("CSV file: {csvfile}", csvfile=csvfile.name)

    cal = convert_csv_to_ical(csvfile)

    icalfile.write(cal)

    logger.info("iCal file: {icalfile}", icalfile=icalfile.name)


if __name__ == "__main__":
    cli()
