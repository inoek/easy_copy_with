import 'package:easy_copy_with/easy_copy_with.dart';

part 'example.g.dart';

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

@CopyWith()
class User {
  final String name;
  final int age;
  final String? email;
  final bool isActive;

  const User({
    required this.name,
    required this.age,
    this.email,
    this.isActive = true,
  });

  @override
  String toString() =>
      'User(name: $name, age: $age, email: $email, isActive: $isActive)';
}
