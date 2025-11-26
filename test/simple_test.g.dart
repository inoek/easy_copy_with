// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef TestPersonCopyWithFn = TestPerson Function({String name, int age});

const Object _testPersonCopyWithPlaceholder = Object();

extension TestPersonCopyWith on TestPerson {
  TestPersonCopyWithFn get copyWith {
    final instance = this;
    TestPerson copyWithFn({
      Object name = _testPersonCopyWithPlaceholder,
      Object age = _testPersonCopyWithPlaceholder,
    }) {
      return TestPerson(
        name: identical(name, _testPersonCopyWithPlaceholder)
            ? instance.name
            : name as String,
        age: identical(age, _testPersonCopyWithPlaceholder)
            ? instance.age
            : age as int,
      );
    }

    return copyWithFn as TestPersonCopyWithFn;
  }
}

typedef TestUserCopyWithFn = TestUser Function({String name, String? email});

const Object _testUserCopyWithPlaceholder = Object();

extension TestUserCopyWith on TestUser {
  TestUserCopyWithFn get copyWith {
    final instance = this;
    TestUser copyWithFn({
      Object name = _testUserCopyWithPlaceholder,
      Object? email = _testUserCopyWithPlaceholder,
    }) {
      return TestUser(
        name: identical(name, _testUserCopyWithPlaceholder)
            ? instance.name
            : name as String,
        email: identical(email, _testUserCopyWithPlaceholder)
            ? instance.email
            : email as String?,
      );
    }

    return copyWithFn as TestUserCopyWithFn;
  }
}
