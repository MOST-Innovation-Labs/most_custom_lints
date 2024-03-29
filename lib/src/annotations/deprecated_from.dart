/// Marks a feature as [DeprecatedFrom].
class DeprecatedFrom {
  /// Message provided to the user.
  final String message;

  /// Date when this info lint info should become a warning lint.
  final DeprecationDate deprecationDate;

  /// Create a deprecation annotation.
  const DeprecatedFrom(this.message, this.deprecationDate);

  @override
  String toString() => "Deprecated feature from $deprecationDate: $message";
}

/// Marks a specific deprecation deadline for [DeprecatedFrom].
class DeprecationDate {
  /// The year.
  final int year;

  /// The month [1..12].
  final int month;

  /// The day [1..31].
  final int dayOfMonth;

  /// Create a deprecation date for [DeprecatedFrom].
  const DeprecationDate(
    this.year,
    this.month,
    this.dayOfMonth,
  );

  @override
  String toString() => '[DeprecationDate $year/$month/$dayOfMonth]';
}
