import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'sealed_class_with_fields_test.g.dart';

void main() {
  group('Sealed Class With Base Field CopyWith', () {
    test('IntA copyWith updates both base and a', () {
      const model = SealedWithField.intA(baseValue: 1, a: 2);
      final copied = (model as IntA).copyWith(baseValue: 10, a: 3);

      expect(copied, isA<IntA>());
      final asIntA = copied;
      expect(asIntA.baseValue, 10);
      expect(asIntA.a, 3);
    });

    test('IntB copyWith updates base or b separately', () {
      const model = SealedWithField.intB(baseValue: 5, b: 'x');
      final copied1 = (model as IntB).copyWith(baseValue: 20, b: 'r');
      expect(copied1, isA<IntB>());
      expect(copied1.baseValue, 20);
      expect(copied1.b, 'r');

      final copied2 = model.copyWith(b: 'y');
      expect(copied2, isA<IntB>());
      expect(copied2.baseValue, 5);
      expect(copied2.b, 'y');
    });
  });
}

@CopyWith()
sealed class SealedWithField {
  final int baseValue;

  const factory SealedWithField.intA({required int baseValue, required int a}) =
      IntA;
  const factory SealedWithField.intB({
    required int baseValue,
    required String b,
  }) = IntB;

  const SealedWithField._(this.baseValue);
}

final class IntA extends SealedWithField {
  const IntA({required int baseValue, required this.a}) : super._(baseValue);

  final int a;
}

final class IntB extends SealedWithField {
  const IntB({required int baseValue, required this.b}) : super._(baseValue);

  final String b;
}
