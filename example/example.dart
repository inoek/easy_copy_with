import 'package:easy_copy_with_example/user.dart';

void main() {
  const user = User(name: 'Alice', age: 25, email: 'alice@example.com');

  final older = user.copyWith(age: 26);
  final renamed = older.copyWith(name: 'Alicia');
  final withoutEmail = renamed.copyWith(email: null);

  print(user);
  print(older);
  print(renamed);
  print(withoutEmail);
}
