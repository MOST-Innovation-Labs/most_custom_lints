<h1> most_custom_lints </h1>

<p align="center">
  <a href="https://pub.dev/packages/most_custom_lints">
    <img src="https://img.shields.io/pub/v/most_custom_lints.svg?label=pub&color=orange" alt="pub version">
  </a>
</p>

Custom lints that are used by MOST.

- [Rules](#rules)
  - [deprecated\_from\_expired](#deprecated_from_expired)
  - [use\_deprecated\_from](#use_deprecated_from)


## Rules
### deprecated_from_expired

It is a common practice within technology organisations to employ short-lived feature flags in continuous integration workflows. This approach allows for the integration of untested features into the main branch, representing a form of deliberate technical debt designed to facilitate smoother development flows. While the adoption of short-lived feature flags is beneficial, it often leads to challenges in maintenance when these flags are not promptly cleaned up, eventually turning into a maintenance nightmare.

To address this, our annotation provides a straightforward solution to ensure timely cleanup of these feature flags. By reminding the team to remove the flags after a predetermined number of days, we not only encourage proactive management of technical debt but also enhance team communication and collaboration. This reminder serves as a nudge for the team to collectively remember and act on the cleanup, ensuring that these temporary measures do not outstay their welcome.

**DO** use `DeprecatedFrom` to raise a warning after a specified date.

**GOOD:**
```dart
@DeprecatedFrom(
    'Must be addressed before the Y2K',
    DeprecationDate(1999, 01, 01)
)
String getYear() => '19$_year';
```



### use_deprecated_from
**DO** use `DeprecatedFrom` instead of `Deprecated`.

Note that it intentionally does not affect `@deprecated` annotation.

**BAD:**
```dart
@Deprecated('Use `getYearNew` instead.')
String getYear() => '19$_year';
String getYearNew() => (1900 + _year).toString();
```

**GOOD:**
```dart
@DeprecatedFrom(
    'All occurences must be replaced with `getYearNew` before Y2K.',
    DeprecationDate(1999, 01, 01)
)
String getYear() => '19$_year';
String getYearNew() => (1900 + _year).toString();
```
