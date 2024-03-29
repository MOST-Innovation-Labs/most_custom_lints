class DeprecatedFrom {
  final String message;
  final DeprecationDate deprecationDate;

  const DeprecatedFrom(this.message, this.deprecationDate);

  @override
  String toString() => "Deprecated feature from $deprecationDate: $message";
}

class DeprecationDate {
  final int year;
  final int month;
  final int dayOfMonth;

  const DeprecationDate(
    this.year,
    this.month,
    this.dayOfMonth,
  );

  @override
  String toString() => '[DeprecationDate $year/$month/$dayOfMonth]';
}
