import csv
from datetime import date, datetime, timedelta

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
            name = "{0} {1}".format(row["First Name"], row["Last Name"]).strip()
            summary = "{0} hat Geburtstag".format(name)

            try:
                birthday = datetime.strptime(row["Birthday"], "%Y-%m-%d")
            except ValueError:
                pass

            try:
                birthday = datetime.strptime(
                    "{0};{1}".format(row["Birthday"], "1900"), " --%m-%d;%Y"
                )
            except ValueError:
                pass

            logger.debug(
                "Name: {n} - Date: {b}",
                n=name,
                b=birthday.date(),
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
