// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integration_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef PersonCopyWithFn = Person Function({String name, int age});

const Object _personCopyWithPlaceholder = Object();

extension PersonCopyWith on Person {
  PersonCopyWithFn get copyWith {
    final instance = this;
    Person copyWithFn({
      Object name = _personCopyWithPlaceholder,
      Object age = _personCopyWithPlaceholder,
    }) {
      return Person(
        name: identical(name, _personCopyWithPlaceholder)
            ? instance.name
            : name as String,
        age: identical(age, _personCopyWithPlaceholder)
            ? instance.age
            : age as int,
      );
    }

    return copyWithFn as PersonCopyWithFn;
  }
}

typedef UserCopyWithFn = User Function({String name, String? email, int? age});

const Object _userCopyWithPlaceholder = Object();

extension UserCopyWith on User {
  UserCopyWithFn get copyWith {
    final instance = this;
    User copyWithFn({
      Object name = _userCopyWithPlaceholder,
      Object? email = _userCopyWithPlaceholder,
      Object? age = _userCopyWithPlaceholder,
    }) {
      return User(
        name: identical(name, _userCopyWithPlaceholder)
            ? instance.name
            : name as String,
        email: identical(email, _userCopyWithPlaceholder)
            ? instance.email
            : email as String?,
        age: identical(age, _userCopyWithPlaceholder)
            ? instance.age
            : age as int?,
      );
    }

    return copyWithFn as UserCopyWithFn;
  }
}

typedef ConfigurationCopyWithFn =
    Configuration Function({
      Map<String, String> settings,
      List<String> features,
      Map<String, dynamic>? metadata,
    });

const Object _configurationCopyWithPlaceholder = Object();

extension ConfigurationCopyWith on Configuration {
  ConfigurationCopyWithFn get copyWith {
    final instance = this;
    Configuration copyWithFn({
      Object settings = _configurationCopyWithPlaceholder,
      Object features = _configurationCopyWithPlaceholder,
      Object? metadata = _configurationCopyWithPlaceholder,
    }) {
      return Configuration(
        settings: identical(settings, _configurationCopyWithPlaceholder)
            ? instance.settings
            : settings as Map<String, String>,
        features: identical(features, _configurationCopyWithPlaceholder)
            ? instance.features
            : features as List<String>,
        metadata: identical(metadata, _configurationCopyWithPlaceholder)
            ? instance.metadata
            : metadata as Map<String, dynamic>?,
      );
    }

    return copyWithFn as ConfigurationCopyWithFn;
  }
}
