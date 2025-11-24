import 'package:easy_copy_with/annotations.dart';
import 'package:test/test.dart';

part 'sealed_class_without_factories_test.g.dart';

void main() {
  group('Sealed Class Without Factories CopyWith', () {
    test('SealedA copyWith updates both base and a', () {
      const model = SealedA(baseValue: 1, a: 2);
      final copied = model.copyWith(baseValue: 10, a: 3);

      expect(copied, isA<SealedA>());
      expect(copied.baseValue, 10);
      expect(copied.a, 3);
    });

    test('SealedB copyWith updates base or b separately', () {
      const model = SealedB(baseValue: 5, b: 'x');
      final copied1 = model.copyWith(baseValue: 20, b: 'r');
      expect(copied1, isA<SealedB>());
      expect(copied1.baseValue, 20);
      expect(copied1.b, 'r');

      final copied2 = model.copyWith(b: 'y');
      expect(copied2, isA<SealedB>());
      expect(copied2.baseValue, 5);
      expect(copied2.b, 'y');
    });
  });
}

@CopyWith()
sealed class SealedWithoutFactories {
  final int baseValue;

  const SealedWithoutFactories._(this.baseValue);
}

@CopyWith()
final class SealedA extends SealedWithoutFactories {
  const SealedA({required int baseValue, required this.a}) : super._(baseValue);

  final int a;
}

@CopyWith()
final class SealedB extends SealedWithoutFactories {
  const SealedB({required int baseValue, required this.b}) : super._(baseValue);

  final String b;
}
