import 'package:easy_copy_with/easy_copy_with.dart';

part 'user.g.dart';

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
