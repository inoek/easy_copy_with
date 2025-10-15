// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef UserCopyWithFn =
    User Function({String? name, int? age, String? email, bool? isActive});

const Object _userCopyWithPlaceholder = Object();

extension UserCopyWith on User {
  UserCopyWithFn get copyWith {
    final instance = this;
    User copyWithFn({
      Object? name = _userCopyWithPlaceholder,
      Object? age = _userCopyWithPlaceholder,
      Object? email = _userCopyWithPlaceholder,
      Object? isActive = _userCopyWithPlaceholder,
    }) {
      return User(
        name: identical(name, _userCopyWithPlaceholder) || name == null
            ? instance.name
            : name as String,
        age: identical(age, _userCopyWithPlaceholder) || age == null
            ? instance.age
            : age as int,
        email: identical(email, _userCopyWithPlaceholder)
            ? instance.email
            : email as String?,
        isActive:
            identical(isActive, _userCopyWithPlaceholder) || isActive == null
            ? instance.isActive
            : isActive as bool,
      );
    }

    return copyWithFn as UserCopyWithFn;
  }
}
