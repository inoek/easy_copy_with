// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'integration_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PersonCopyWith on Person {
  Person copyWith({String? name, int? age}) {
    return Person(name: name ?? this.name, age: age ?? this.age);
  }
}

extension UserCopyWith on User {
  User copyWith({
    String? name,
    Object? email = const Object(),
    Object? age = const Object(),
  }) {
    return User(
      name: name ?? this.name,
      email: email == const Object() ? this.email : email as String?,
      age: age == const Object() ? this.age : age as int?,
    );
  }
}

extension ConfigurationCopyWith on Configuration {
  Configuration copyWith({
    Map<String, String>? settings,
    List<String>? features,
    Object? metadata = const Object(),
  }) {
    return Configuration(
      settings: settings ?? this.settings,
      features: features ?? this.features,
      metadata: metadata == const Object()
          ? this.metadata
          : metadata as Map<String, dynamic>?,
    );
  }
}
