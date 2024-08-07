import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:most_custom_lints/src/utils/type_utils.dart';

class UseDeprecatedFromLintRule extends DartLintRule {
  UseDeprecatedFromLintRule()
      : super(
          code: LintCode(
            name: 'use_deprecated_from',
            problemMessage:
                'Use `DeprecatedFrom` from `package:most_custom_lints` instead.',
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

      final deprecatedUsages =
          annotations.where((e) => e.hasType('Deprecated'));

      if (deprecatedUsages.isNotEmpty) {
        reporter.atNode(
          node,
          LintCode(
            name: code.name,
            problemMessage: code.problemMessage,
            errorSeverity: ErrorSeverity.INFO,
          ),
        );
      }
    });
  }
}
