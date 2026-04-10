// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_with_fields_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

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

typedef IntBCopyWithFn = IntB Function({int baseValue, String b});

const Object _intBCopyWithPlaceholder = Object();

extension IntBCopyWith on IntB {
  IntBCopyWithFn get copyWith {
    final instance = this;
    IntB copyWithFn({
      Object baseValue = _intBCopyWithPlaceholder,
      Object b = _intBCopyWithPlaceholder,
    }) {
      return IntB(
        baseValue: identical(baseValue, _intBCopyWithPlaceholder)
            ? instance.baseValue
            : baseValue as int,
        b: identical(b, _intBCopyWithPlaceholder) ? instance.b : b as String,
      );
    }

    return copyWithFn as IntBCopyWithFn;
  }
}
