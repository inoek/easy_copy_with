// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_with_extended_fields_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef SealedClassWithExtendedFieldsCopyWithFn =
    SealedClassWithExtendedFields Function({int a});

extension SealedClassWithExtendedFieldsCopyWith
    on SealedClassWithExtendedFields {
  SealedClassWithExtendedFieldsCopyWithFn get copyWith {
    return switch (this) {
      final IntA x0 => x0.copyWith,
      final IntB x1 => x1.copyWith,
    };
  }
}

typedef IntACopyWithFn = IntA Function({int baseValue, int a});

const Object _intACopyWithPlaceholder = Object();

extension IntACopyWith on IntA {
  IntACopyWithFn get copyWith {
    final instance = this;
    IntA copyWithFn({
      Object baseValue = _intACopyWithPlaceholder,
      Object a = _intACopyWithPlaceholder,
    }) {
      return IntA(
        baseValue: identical(baseValue, _intACopyWithPlaceholder)
            ? instance.baseValue
            : baseValue as int,
        a: identical(a, _intACopyWithPlaceholder) ? instance.a : a as int,
      );
    }

    return copyWithFn as IntACopyWithFn;
  }
}

typedef IntBCopyWithFn = IntB Function({int baseValue, int a});

const Object _intBCopyWithPlaceholder = Object();

extension IntBCopyWith on IntB {
  IntBCopyWithFn get copyWith {
    final instance = this;
    IntB copyWithFn({
      Object baseValue = _intBCopyWithPlaceholder,
      Object a = _intBCopyWithPlaceholder,
    }) {
      return IntB(
        baseValue: identical(baseValue, _intBCopyWithPlaceholder)
            ? instance.baseValue
            : baseValue as int,
        a: identical(a, _intBCopyWithPlaceholder) ? instance.a : a as int,
      );
    }

    return copyWithFn as IntBCopyWithFn;
  }
}
