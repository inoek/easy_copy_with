import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'sealed_class_test.g.dart';

void main() {
  group('Sealed Class CopyWith', () {
    test('IntValueSealedTestModel copyWith', () {
      const model = SealedTestModel.intValue(value: 42);
      final copiedModel = (model as IntValueSealedTestModel).copyWith(
        value: 100,
      );

      expect(model, isA<IntValueSealedTestModel>());
      expect(copiedModel.value, 100);
    });

    test('StringValueSealedTestModel copyWith', () {
      const model = SealedTestModel.stringValue(name: 'Hello');
      final copiedModel = (model as StringValueSealedTestModel).copyWith(
        name: 'World',
      );

      expect(model, isA<StringValueSealedTestModel>());
      expect(copiedModel.name, 'World');
    });
  });
}

@CopyWith()
sealed class SealedTestModel {
  const factory SealedTestModel.intValue({required int value}) =
      IntValueSealedTestModel;

  const factory SealedTestModel.stringValue({required String name}) =
      StringValueSealedTestModel;

  const SealedTestModel._();
}

final class IntValueSealedTestModel extends SealedTestModel {
  const IntValueSealedTestModel({required this.value}) : super._();

  final int value;
}

final class StringValueSealedTestModel extends SealedTestModel {
  const StringValueSealedTestModel({required this.name}) : super._();

  final String name;
}
