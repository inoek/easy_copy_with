// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'simple_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PersonCopyWith on Person {
  Person copyWith({String? name, int? age, Object? email = const Object()}) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email == const Object() ? this.email : email as String?,
    );
  }
}
