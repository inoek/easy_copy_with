// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef IntValueSealedTestModelCopyWithFn =
    IntValueSealedTestModel Function({int intValue});

const Object _intValueSealedTestModelCopyWithPlaceholder = Object();

extension IntValueSealedTestModelCopyWith on IntValueSealedTestModel {
  IntValueSealedTestModelCopyWithFn get copyWith {
    final instance = this;
    IntValueSealedTestModel copyWithFn({
      Object intValue = _intValueSealedTestModelCopyWithPlaceholder,
    }) {
      return IntValueSealedTestModel(
        intValue:
            identical(intValue, _intValueSealedTestModelCopyWithPlaceholder)
            ? instance.intValue
            : intValue as int,
      );
    }

    return copyWithFn as IntValueSealedTestModelCopyWithFn;
  }
}

typedef StringValueSealedTestModelCopyWithFn =
    StringValueSealedTestModel Function({String name});

const Object _stringValueSealedTestModelCopyWithPlaceholder = Object();

extension StringValueSealedTestModelCopyWith on StringValueSealedTestModel {
  StringValueSealedTestModelCopyWithFn get copyWith {
    final instance = this;
    StringValueSealedTestModel copyWithFn({
      Object name = _stringValueSealedTestModelCopyWithPlaceholder,
    }) {
      return StringValueSealedTestModel(
        name: identical(name, _stringValueSealedTestModelCopyWithPlaceholder)
            ? instance.name
            : name as String,
      );
    }

    return copyWithFn as StringValueSealedTestModelCopyWithFn;
  }
}
