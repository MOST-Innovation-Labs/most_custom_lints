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
