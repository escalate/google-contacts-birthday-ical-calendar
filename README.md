[![Test](https://github.com/escalate/google-contacts-birthday-ical-calendar/actions/workflows/test.yml/badge.svg?branch=master&event=push)](https://github.com/escalate/google-contacts-birthday-ical-calendar/actions/workflows/test.yml)

# Google Contacts birthday to iCal calendar converter

This commandline tool converts birthday events of an CSV export of [Google Contacts](https://contacts.google.com/) via [Google Takeout](https://takeout.google.com/) into a iCal calendar file.

The iCal calendar file can then be imported into [Google Calendar](https://calendar.google.com/) to create notifications for birthdays of your contacts.

## 📚 Usage

1. Build the Docker image.

```
$ make build-docker-image
```

2. Run Docker container from built image to print help.

```
$ make run-docker-image

Usage: cli.py [OPTIONS] CSVFILE ICALFILE

  Google Contacts birthday to iCal calendar converter

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
    google-contacts-birthday-ical-calendar \
    example.csv \
    example.ics \
    --verbose
```

## 🧩 Similar Projects

If you’re interested in similar or related projects, check out:

- Google Apps Script which sends emails for birthdays of Google contacts [GoogleContactsEventsNotifier](https://github.com/GioBonvi/GoogleContactsEventsNotifier)

## 🤝 Contributing

We welcome contributions of all kinds 🎉.

Please read our [Contributing](https://github.com/escalate/google-contacts-birthday-ical-calendar/blob/master/CONTRIBUTING.md) guide to learn how to get started, submit changes, and follow our contribution standards.

## 🌐 Code of Conduct

This project follows a [Code of Conduct](https://github.com/escalate/google-contacts-birthday-ical-calendar/blob/master/CODE_OF_CONDUCT.md) to ensure a welcoming and respectful community.

By participating, you agree to uphold this standard.

## 🐛 Issues

Found a bug or want to request a feature?

Open an issue here: [GitHub Issues](https://github.com/escalate/google-contacts-birthday-ical-calendar/issues)

## 🧪 Development

Development is possible via an interactive Docker container in [VSCode](https://code.visualstudio.com/).

1. Build and launch the [DevContainer](https://code.visualstudio.com/docs/devcontainers/containers) in VSCode.

2. Initiate the Python Virtual Environment via `poetry env activate` in the terminal.

3. Run test suite via `pytest` in the terminal.

## 📜 License

This project is licensed under the **MIT License**.

See the [LICENSE](https://github.com/escalate/google-contacts-birthday-ical-calendar/blob/master/LICENSE) file for details.
