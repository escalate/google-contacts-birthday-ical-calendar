# Contributing

- Search on [GitHub](https://github.com/escalate/google-contacts-birthday-ical-calendar/pulls) for an open or closed Pull Request that relates to your submission. You don't want to duplicate effort.
- Create the development environment as described in [README.md](https://github.com/escalate/google-contacts-birthday-ical-calendar/blob/master/README.md).
- Make your changes in a new git branch:

  ```shell
  git checkout -b my-branch master
  ```

- Create your patch commit, **including appropriate test cases**.
- Run the test tool and ensure that all unit tests and lint checks pass.

  ```shell
  make lint-python

  make test-python
  ```

- Commit your changes using a descriptive commit message that follows the [AngularJS Commit Message Format](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#commits).
  Adherence to the commit message conventions is required, because release versions and release notes are automatically generated from these messages.
- After the review process for new features and bugfixes is done, please squash multiple commits to a single one. Single commits make it easier to revert later in case of problems.
