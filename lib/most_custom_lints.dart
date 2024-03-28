library;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:meta/meta.dart';

import 'src/dart_lint_rules/deprecated_from_expired_lint_rule.dart';
import 'src/dart_lint_rules/use_deprecated_from_lint_rule.dart';

@visibleForTesting
PluginBase createPlugin() => _MostCustomLintPlugin();

class _MostCustomLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        UseDeprecatedFromLintRule(),
        DeprecatedFromExpiredLintRule(),
      ];
}
