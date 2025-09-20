// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'null_assignment_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension TestModelCopyWith on TestModel {
  TestModel copyWith({
    String? name,
    Object? email = const Object(),
    Object? age = const Object(),
  }) {
    return TestModel(
      name: name ?? this.name,
      email: email == const Object() ? this.email : email as String?,
      age: age == const Object() ? this.age : age as int?,
    );
  }
}
