// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef AdminCopyWithFn = Admin Function({int adminLevel, bool isActive});

const Object _adminCopyWithPlaceholder = Object();

extension AdminCopyWith on Admin {
  AdminCopyWithFn get copyWith {
    final instance = this;
    Admin copyWithFn({
      Object adminLevel = _adminCopyWithPlaceholder,
      Object isActive = _adminCopyWithPlaceholder,
    }) {
      return Admin(
        adminLevel: identical(adminLevel, _adminCopyWithPlaceholder)
            ? instance.adminLevel
            : adminLevel as int,
        isActive: identical(isActive, _adminCopyWithPlaceholder)
            ? instance.isActive
            : isActive as bool,
      );
    }

    return copyWithFn as AdminCopyWithFn;
  }
}

typedef UserRoleCopyWithFn =
    UserRole Function({String username, bool isActive});

const Object _userRoleCopyWithPlaceholder = Object();

extension UserRoleCopyWith on UserRole {
  UserRoleCopyWithFn get copyWith {
    final instance = this;
    UserRole copyWithFn({
      Object username = _userRoleCopyWithPlaceholder,
      Object isActive = _userRoleCopyWithPlaceholder,
    }) {
      return UserRole(
        username: identical(username, _userRoleCopyWithPlaceholder)
            ? instance.username
            : username as String,
        isActive: identical(isActive, _userRoleCopyWithPlaceholder)
            ? instance.isActive
            : isActive as bool,
      );
    }

    return copyWithFn as UserRoleCopyWithFn;
  }
}
