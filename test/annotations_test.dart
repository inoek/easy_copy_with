import 'package:test/test.dart';
import 'package:easy_copy_with/annotations.dart';

void main() {
  group('CopyWith annotation', () {
    test('should be instantiable', () {
      const annotation = CopyWith();
      expect(annotation, isA<CopyWith>());
    });

    test('should be const', () {
      const annotation1 = CopyWith();
      const annotation2 = CopyWith();
      expect(annotation1, equals(annotation2));
    });

    test('should have correct runtime type', () {
      const annotation = CopyWith();
      expect(annotation.runtimeType, equals(CopyWith));
    });

    test('should be usable as metadata', () {
      expect(() => const TestClassWithAnnotation(name: 'test', value: 42), returnsNormally);
    });
  });
}

@CopyWith()
class TestClassWithAnnotation {
  final String name;
  final int value;

  const TestClassWithAnnotation({
    required this.name,
    required this.value,
  });
}