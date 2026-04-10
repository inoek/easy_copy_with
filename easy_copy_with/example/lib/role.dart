import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart';

part 'role.g.dart';

@CopyWith()
sealed class Role {
  const factory Role.admin({required int adminLevel, bool isActive}) = Admin;

  const factory Role.userRole({required String username, bool isActive}) =
      UserRole;

  const Role._({this.isActive = true});

  final bool isActive;
}

final class Admin extends Role {
  const Admin({required this.adminLevel, super.isActive}) : super._();

  final int adminLevel;
}

final class UserRole extends Role {
  const UserRole({required this.username, super.isActive}) : super._();

  final String username;
}
