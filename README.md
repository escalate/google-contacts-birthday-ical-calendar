[![Test](https://github.com/escalate/google-contacts-birthday-ical-calendar/actions/workflows/test.yml/badge.svg?branch=master&event=push)](https://github.com/escalate/google-contacts-birthday-ical-calendar/actions/workflows/test.yml)

# Google Contacts birthday to iCal calendar converter

This commandline tool converts birthday events of an CSV export of [Google Contacts](https://contacts.google.com/) via [Google Takeout](https://takeout.google.com/) into a iCal calendar file.

The iCal calendar file can then be imported into [Google Calendar](https://calendar.google.com/) to create notifications for birthdays of your contacts.

## Install dependencies

Install needed dependencies via [Poetry](https://python-poetry.org/)

```
$ make install-dependencies
```

## Usage

Run tool from commandline
```
$ ./converter.py --help

Usage: converter.py [OPTIONS] CSVFILE ICALFILE

    Commandline interface for Google Contacts birthday to iCal calendar
    converter

Options:
    --verbose  Enable verbose logging output.
    --help     Show this message and exit.
```

## Docker

Build Docker image
```
$ make build-docker-image
```

Run Docker container from built image to print help
```
$ docker run googlecontactsbirthdayicalcalendar:latest
```

Run Docker container from built image with additional arguments
```
$ docker run \
    --volume=$(pwd):/data:rw \
    googlecontactsbirthdayicalcalendar:latest \
    example.csv \
    examle.ics \
    --verbose
```

## Other Projects

* Google Apps Script which sends emails for birthdays of Google contacts [GoogleContactsEventsNotifier](https://github.com/GioBonvi/GoogleContactsEventsNotifier)

## License

MIT
