// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef AdminCopyWithFn = Admin Function({bool isActive, int adminLevel});

const Object _adminCopyWithPlaceholder = Object();

extension AdminCopyWith on Admin {
  AdminCopyWithFn get copyWith {
    final instance = this;
    Admin copyWithFn({
      Object isActive = _adminCopyWithPlaceholder,
      Object adminLevel = _adminCopyWithPlaceholder,
    }) {
      return Admin(
        isActive: identical(isActive, _adminCopyWithPlaceholder)
            ? instance.isActive
            : isActive as bool,
        adminLevel: identical(adminLevel, _adminCopyWithPlaceholder)
            ? instance.adminLevel
            : adminLevel as int,
      );
    }

    return copyWithFn as AdminCopyWithFn;
  }
}

typedef UserRoleCopyWithFn =
    UserRole Function({bool isActive, String username});

const Object _userRoleCopyWithPlaceholder = Object();

extension UserRoleCopyWith on UserRole {
  UserRoleCopyWithFn get copyWith {
    final instance = this;
    UserRole copyWithFn({
      Object isActive = _userRoleCopyWithPlaceholder,
      Object username = _userRoleCopyWithPlaceholder,
    }) {
      return UserRole(
        isActive: identical(isActive, _userRoleCopyWithPlaceholder)
            ? instance.isActive
            : isActive as bool,
        username: identical(username, _userRoleCopyWithPlaceholder)
            ? instance.username
            : username as String,
      );
    }

    return copyWithFn as UserRoleCopyWithFn;
  }
}
