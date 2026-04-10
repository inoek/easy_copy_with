// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_shared_fields_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef SealedTestModelSharedFieldsCopyWithFn =
    SealedTestModelSharedFields Function({int intValue, Iterable<int> same});

extension SealedTestModelSharedFieldsCopyWith on SealedTestModelSharedFields {
  SealedTestModelSharedFieldsCopyWithFn get copyWith {
    return switch (this) {
      final ASealedTestModelSharedFields x0 => x0.copyWith,
      final BSealedTestModelSharedFields x1 => x1.copyWith,
    };
  }
}

typedef ASealedTestModelSharedFieldsCopyWithFn =
    ASealedTestModelSharedFields Function({
      int intValue,
      Iterable<String> b,
      Iterable<int> same,
    });

const Object _aSealedTestModelSharedFieldsCopyWithPlaceholder = Object();

extension ASealedTestModelSharedFieldsCopyWith on ASealedTestModelSharedFields {
  ASealedTestModelSharedFieldsCopyWithFn get copyWith {
    final instance = this;
    ASealedTestModelSharedFields copyWithFn({
      Object intValue = _aSealedTestModelSharedFieldsCopyWithPlaceholder,
      Object b = _aSealedTestModelSharedFieldsCopyWithPlaceholder,
      Object same = _aSealedTestModelSharedFieldsCopyWithPlaceholder,
    }) {
      return ASealedTestModelSharedFields(
        intValue:
            identical(
              intValue,
              _aSealedTestModelSharedFieldsCopyWithPlaceholder,
            )
            ? instance.intValue
            : intValue as int,
        b: identical(b, _aSealedTestModelSharedFieldsCopyWithPlaceholder)
            ? instance.b
            : b as Iterable<String>,
        same: identical(same, _aSealedTestModelSharedFieldsCopyWithPlaceholder)
            ? instance.same
            : same as Iterable<int>,
      );
    }

    return copyWithFn as ASealedTestModelSharedFieldsCopyWithFn;
  }
}

typedef BSealedTestModelSharedFieldsCopyWithFn =
    BSealedTestModelSharedFields Function({
      int intValue,
      Iterable<String> a,
      Iterable<int> same,
    });

const Object _bSealedTestModelSharedFieldsCopyWithPlaceholder = Object();

extension BSealedTestModelSharedFieldsCopyWith on BSealedTestModelSharedFields {
  BSealedTestModelSharedFieldsCopyWithFn get copyWith {
    final instance = this;
    BSealedTestModelSharedFields copyWithFn({
      Object intValue = _bSealedTestModelSharedFieldsCopyWithPlaceholder,
      Object a = _bSealedTestModelSharedFieldsCopyWithPlaceholder,
      Object same = _bSealedTestModelSharedFieldsCopyWithPlaceholder,
    }) {
      return BSealedTestModelSharedFields(
        intValue:
            identical(
              intValue,
              _bSealedTestModelSharedFieldsCopyWithPlaceholder,
            )
            ? instance.intValue
            : intValue as int,
        a: identical(a, _bSealedTestModelSharedFieldsCopyWithPlaceholder)
            ? instance.a
            : a as Iterable<String>,
        same: identical(same, _bSealedTestModelSharedFieldsCopyWithPlaceholder)
            ? instance.same
            : same as Iterable<int>,
      );
    }

    return copyWithFn as BSealedTestModelSharedFieldsCopyWithFn;
  }
}
