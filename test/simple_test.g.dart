// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'simple_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension TestPersonCopyWith on TestPerson {
  TestPerson copyWith({String? name, int? age}) {
    return TestPerson(name: name ?? this.name, age: age ?? this.age);
  }
}

extension TestUserCopyWith on TestUser {
  TestUser copyWith({String? name, Object? email = const Object()}) {
    return TestUser(
      name: name ?? this.name,
      email: email == const Object() ? this.email : email as String?,
    );
  }
}
