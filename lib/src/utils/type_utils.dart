import 'package:analyzer/dart/ast/ast.dart' show Annotation;

extension AnnotationExtension on Annotation {
  // TODO use `analyzer` for the check
  bool hasType(String typeName) => name.name == typeName;
}
