import 'annotations_test.dart' as annotations;
import 'simple_test.dart' as simple;
import 'integration_test.dart' as integration;
import 'edge_cases_test.dart' as edge_cases;
import 'sealed_class_test.dart' as sealed_class;
import 'sealed_class_with_fields_test.dart' as sealed_class_with_fields;

void main() {
  annotations.main();
  simple.main();
  integration.main();
  edge_cases.main();
  sealed_class.main();
  sealed_class_with_fields.main();
}
