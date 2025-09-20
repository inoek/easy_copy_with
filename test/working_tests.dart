// Working tests runner
// This file contains only the tests that currently pass
// Run with: dart test test/working_tests.dart

import 'annotations_test.dart' as annotations;
import 'simple_test.dart' as simple;

void main() {
  annotations.main();
  simple.main();
}