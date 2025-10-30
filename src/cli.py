#!/usr/bin/env python
import sys

import click
from loguru import logger

from google_contacts_birthday_ical_calendar.convert_csv_to_ical import (
    convert_csv_to_ical,
)


@click.command()
@click.argument(
    "csvfile",
    type=click.File("r"),
)
@click.argument(
    "icalfile",
    type=click.File("wb"),
)
@click.option(
    "--verbose",
    is_flag=True,
    help="Enable verbose logging output.",
)
def cli(csvfile, icalfile, verbose):
    """Google Contacts birthday to iCal calendar converter

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
    logger.remove(0)
    logger.add(
        sys.stdout,
        level="INFO",
        format='time={time} level={level} msg="{message}"',
    )
    cli()
