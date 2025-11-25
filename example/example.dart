import 'package:easy_copy_with_example/role.dart';
import 'package:easy_copy_with_example/user.dart';

void main() {
  const user = User(name: 'Alice', age: 25, email: 'alice@example.com');
  const role = Role.admin(adminLevel: 1, isActive: true);

  final older = user.copyWith(age: 26);
  final renamed = older.copyWith(name: 'Alicia');
  final withoutEmail = renamed.copyWith(email: null);

  final updatedRole = (role as Admin).copyWith(isActive: false);

  print(user);
  print(older);
  print(renamed);
  print(withoutEmail);
  print(
    'Admin Role: adminLevel=${updatedRole.adminLevel}, isActive=${updatedRole.isActive}',
  );
}
