// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'null_assignment_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef TestModelCopyWithFn =
    TestModel Function({String name, String? email, int? age});

const Object _testModelCopyWithPlaceholder = Object();

extension TestModelCopyWith on TestModel {
  TestModelCopyWithFn get copyWith {
    final instance = this;
    TestModel copyWithFn({
      Object name = _testModelCopyWithPlaceholder,
      Object? email = _testModelCopyWithPlaceholder,
      Object? age = _testModelCopyWithPlaceholder,
    }) {
      return TestModel(
        name: identical(name, _testModelCopyWithPlaceholder)
            ? instance.name
            : name as String,
        email: identical(email, _testModelCopyWithPlaceholder)
            ? instance.email
            : email as String?,
        age: identical(age, _testModelCopyWithPlaceholder)
            ? instance.age
            : age as int?,
      );
    }

    return copyWithFn as TestModelCopyWithFn;
  }
}
