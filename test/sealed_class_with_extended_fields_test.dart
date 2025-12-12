import 'package:equatable/equatable.dart';
import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'sealed_class_with_extended_fields_test.g.dart';

void main() {
  group('Sealed Class with extended fields from external class', () {
    test('IntA copyWith updates single value', () {
      const model = SealedClassWithExtendedFields.intA(a: 2, baseValue: 42);
      final copied = model.copyWith(a: 3);

      expect(copied, isA<IntA>());
      expect((copied as IntA).a, 3);
    });
  });
}

@CopyWith()
sealed class SealedClassWithExtendedFields with EquatableMixin {
  final int baseValue;

  const factory SealedClassWithExtendedFields.intA({
    required int baseValue,
    required int a,
  }) = IntA;
  const factory SealedClassWithExtendedFields.intB({
    required int baseValue,
    required int a,
  }) = IntB;

  const SealedClassWithExtendedFields._(this.baseValue);

  @override
  List<Object?> get props => [baseValue];
}

final class IntA extends SealedClassWithExtendedFields with EquatableMixin {
  const IntA({required int baseValue, required this.a}) : super._(baseValue);

  final int a;

  @override
  List<Object?> get props => [baseValue, a];
}

final class IntB extends SealedClassWithExtendedFields with EquatableMixin {
  const IntB({required int baseValue, required this.a}) : super._(baseValue);

  final int a;

  @override
  List<Object?> get props => [baseValue, a];
}
