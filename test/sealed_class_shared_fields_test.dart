import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'sealed_class_shared_fields_test.g.dart';

void main() {
  group('Sealed Class CopyWith', () {
    test('ASealedTestModelSharedFields copyWith with shared fields', () {
      const model = SealedTestModelSharedFields.intValue(
        intValue: 42,
        b: ['anotherTest'],
        same: [55],
      );
      final copiedModel = model.copyWith(intValue: 100);

      expect(model, isA<ASealedTestModelSharedFields>());
      expect((copiedModel as ASealedTestModelSharedFields).intValue, 100);
    });

    test('BSealedTestModelSharedFields copyWith with shared fields', () {
      const model = SealedTestModelSharedFields.stringValue(
        intValue: 54,
        a: ['test'],
        same: [42],
      );
      final copiedModel = model.copyWith(intValue: 100, same: [66]);

      expect(model, isA<BSealedTestModelSharedFields>());
      expect(
        (copiedModel as BSealedTestModelSharedFields).intValue,
        equals(100),
      );
      expect(copiedModel.same.firstOrNull, equals(66));
    });
  });
}

@CopyWith()
sealed class SealedTestModelSharedFields {
  const factory SealedTestModelSharedFields.intValue({
    required int intValue,
    required Iterable<String> b,
    required Iterable<int> same,
  }) = ASealedTestModelSharedFields;

  const factory SealedTestModelSharedFields.stringValue({
    required int intValue,
    required Iterable<String> a,
    required Iterable<int> same,
  }) = BSealedTestModelSharedFields;

  const SealedTestModelSharedFields._();
}

final class ASealedTestModelSharedFields extends SealedTestModelSharedFields {
  const ASealedTestModelSharedFields({
    required this.intValue,
    required this.b,
    required this.same,
  }) : super._();

  final int intValue;
  final Iterable<String> b;
  final Iterable<int> same;
}

final class BSealedTestModelSharedFields extends SealedTestModelSharedFields {
  const BSealedTestModelSharedFields({
    required this.intValue,
    required this.a,
    required this.same,
  }) : super._();

  final int intValue;
  final Iterable<String> a;
  final Iterable<int> same;
}
