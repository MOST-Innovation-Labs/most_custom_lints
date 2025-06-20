import 'package:analyzer/dart/constant/value.dart' show DartObject;
import 'package:analyzer/dart/element/element.dart' show ElementAnnotation;
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart' show ErrorReporter;
import 'package:custom_lint_builder/custom_lint_builder.dart'
    show CustomLintContext, CustomLintResolver, DartLintRule, LintCode;
import 'package:most_custom_lints/src/utils/type_utils.dart';

class DeprecatedFromExpiredLintRule extends DartLintRule {
  DeprecatedFromExpiredLintRule()
      : super(
          code: LintCode(
            name: 'deprecated_from_expired',
            problemMessage: 'This node is expired and must be revisited.',
          ),
        );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addAnnotatedNode((node) {
      final annotations = node.metadata;
      if (annotations.isEmpty) return;

      final deprecatedFromObjects = annotations
          .where((e) => e.hasType('DeprecatedFrom'))
          .map((e) => e.elementAnnotation)
          .whereType<ElementAnnotation>()
          .map((e) => e.computeConstantValue())
          .whereType<DartObject>();

      for (final deprecatedFromObject in deprecatedFromObjects) {
        final messageField = deprecatedFromObject.getField('message');
        final message = messageField?.toStringValue() ?? '';
        final deprecationDate = _parseDeprecationDate(deprecatedFromObject);

        if (deprecationDate == null) {
          reporter.atNode(
            node,
            LintCode(
              name: code.name,
              problemMessage: 'Invalid deprecation date.',
              errorSeverity: ErrorSeverity.ERROR,
            ),
          );
        } else if (deprecationDate.isBefore(DateTime.now())) {
          final deprecationDateText = _formatDeprecationDate(deprecationDate);
          reporter.atNode(
            node,
            LintCode(
              name: code.name,
              problemMessage: 'Deprecated on '
                  '$deprecationDateText.\n'
                  'Must be revisited ASAP.\n'
                  '$message',
              errorSeverity: ErrorSeverity.WARNING,
            ),
          );
        } else {
          final deprecationDateText = _formatDeprecationDate(deprecationDate);
          reporter.atNode(
            node,
            LintCode(
              name: code.name,
              problemMessage: 'To be deprecated starting from '
                  '$deprecationDateText.\n'
                  '$message',
              errorSeverity: ErrorSeverity.INFO,
            ),
          );
        }
      }
    });
  }

  DateTime? _parseDeprecationDate(DartObject deprecatedFromObject) {
    final deprecationDate = deprecatedFromObject.getField('deprecationDate');
    if (deprecationDate == null) return null;

    final year = deprecationDate.getField('year')?.toIntValue();
    if (year == null || year < 0 || year > 9999) return null;

    final month = deprecationDate.getField('month')?.toIntValue();
    if (month == null || month < 1 || month > 12) return null;

    final day = deprecationDate.getField('dayOfMonth')?.toIntValue();
    if (day == null || day < 1 || day > 31) return null;

    final DateTime dateTime = DateTime(year, month, day);
    return dateTime;
  }

  String? _formatDeprecationDate(DateTime deprecationDate) {
    final yearText = '${deprecationDate.year}';
    final monthText = switch (deprecationDate.month) {
      DateTime.january => "Jan",
      DateTime.february => "Feb",
      DateTime.march => "Mar",
      DateTime.april => "Apr",
      DateTime.may => "May",
      DateTime.june => "Jun",
      DateTime.july => "Jul",
      DateTime.august => "Aug",
      DateTime.september => "Sep",
      DateTime.october => "Oct",
      DateTime.november => "Nov",
      DateTime.december => "Dec",
      _ => "UNKNOWN_MONTH",
    };

    final dayText = "${deprecationDate.day}".padLeft(2, "0");
    final dateText = '$monthText $dayText, $yearText';
    return dateText;
  }
}
