// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_without_factories_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef SealedACopyWithFn = SealedA Function({int baseValue, int a});

const Object _sealedACopyWithPlaceholder = Object();

extension SealedACopyWith on SealedA {
  SealedACopyWithFn get copyWith {
    final instance = this;
    SealedA copyWithFn({
      Object baseValue = _sealedACopyWithPlaceholder,
      Object a = _sealedACopyWithPlaceholder,
    }) {
      return SealedA(
        baseValue: identical(baseValue, _sealedACopyWithPlaceholder)
            ? instance.baseValue
            : baseValue as int,
        a: identical(a, _sealedACopyWithPlaceholder) ? instance.a : a as int,
      );
    }

    return copyWithFn as SealedACopyWithFn;
  }
}

typedef SealedBCopyWithFn = SealedB Function({int baseValue, String b});

const Object _sealedBCopyWithPlaceholder = Object();

extension SealedBCopyWith on SealedB {
  SealedBCopyWithFn get copyWith {
    final instance = this;
    SealedB copyWithFn({
      Object baseValue = _sealedBCopyWithPlaceholder,
      Object b = _sealedBCopyWithPlaceholder,
    }) {
      return SealedB(
        baseValue: identical(baseValue, _sealedBCopyWithPlaceholder)
            ? instance.baseValue
            : baseValue as int,
        b: identical(b, _sealedBCopyWithPlaceholder) ? instance.b : b as String,
      );
    }

    return copyWithFn as SealedBCopyWithFn;
  }
}
