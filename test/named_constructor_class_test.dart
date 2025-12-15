import 'package:test/test.dart';
import 'package:easy_copy_with/annotations.dart';

part 'named_constructor_class_test.g.dart';

void main() {
  group('CopyWith annotation for named constructor', () {
    test('check compile for named constructor', () {
      expect(
        () => const NamedConstructorClass.named(name: 'test', value: 42),
        returnsNormally,
      );
    });
  });
}

@CopyWith()
class NamedConstructorClass {
  final String name;
  final int value;

  const NamedConstructorClass.named({required this.name, required this.value});
}
