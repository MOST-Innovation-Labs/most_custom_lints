import 'package:most_custom_lints/annotations.dart';

void main() {
  final yearWrapper = YearWrapper(
    yearSince1900: 128,
  );

  print(yearWrapper.getYear());
  print(yearWrapper.yearSince1900);
  print(yearWrapper.year);
  print(yearWrapper.yearText);
  print(yearWrapper.yearTextNew);
}

class YearWrapper {
  @Deprecated('Store the actual year')
  final int yearSince1900;

  YearWrapper({
    required this.yearSince1900,
  });

  @deprecated
  int getYear() => yearSince1900;

  @DeprecatedFrom(
    'All occurences must be replaced with `getYearNew` before Y2K.',
    DeprecationDate(1999, 01, 01),
  )
  String get yearText => yearTextNew;

  @DeprecatedFrom(
    'Must be replaced with `year`',
    DeprecationDate(2050, 01, 01),
  )
  String get yearTextNew => year.toString();

  // ignore: deprecated_member_use_from_same_package
  int get year => (1900 + yearSince1900);
}
