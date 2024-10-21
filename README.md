[![Test](https://github.com/escalate/google-contacts-birthday-ical-calendar/actions/workflows/test.yml/badge.svg?branch=master&event=push)](https://github.com/escalate/google-contacts-birthday-ical-calendar/actions/workflows/test.yml)

# Google Contacts birthday to iCal calendar converter

This commandline tool converts birthday events of an CSV export of [Google Contacts](https://contacts.google.com/) via [Google Takeout](https://takeout.google.com/) into a iCal calendar file.

The iCal calendar file can then be imported into [Google Calendar](https://calendar.google.com/) to create notifications for birthdays of your contacts.

## Usage

Build Docker image
```
$ make build-docker-image
```

Run Docker container from built image to print help
```
$ make run-docker-image

Usage: converter.py [OPTIONS] CSVFILE ICALFILE

  Commandline interface for Google Contacts birthday to iCal calendar
  converter

  CSVFILE is the input .csv filepath.
  ICALFILE is the output .ics filepath.

Options:
  --verbose  Enable verbose logging output.
  --help     Show this message and exit.
```

Run Docker container from built image with custom arguments
```
$ docker compose \
    --file docker-compose.yml \
    run \
    --rm \
    --volume=$(pwd):/data:rw \
    google_contacts_birthday_ical_calendar \
    example.csv \
    example.ics \
    --verbose
```

## Development

Build and launch the [DevContainer](https://code.visualstudio.com/docs/devcontainers/containers) in [VSCode](https://code.visualstudio.com/).

## Other projects

* Google Apps Script which sends emails for birthdays of Google contacts [GoogleContactsEventsNotifier](https://github.com/GioBonvi/GoogleContactsEventsNotifier)

## Contribute

Please note the separate [contributing guide](https://github.com/escalate/google-contacts-birthday-ical-calendar/blob/master/CONTRIBUTING.md).

## License

MIT
