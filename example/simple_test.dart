import 'package:easy_copy_with/easy_copy_with.dart';

part 'simple_test.g.dart';

@CopyWith()
class Person {
  final String name;
  final int age;
  final String? email;

  const Person({
    required this.name,
    required this.age,
    this.email,
  });
}


void main() {
  const person = Person(
    name: 'John Doe',
    age: 30,
    email: 'john@example.com',
  );

  final updatedPerson = person.copyWith(
    age: 31,
    email: 'john.doe@example.com',
  );

  print('Original: ${person.name}, ${person.age}, ${person.email}');
  print('Updated: ${updatedPerson.name}, ${updatedPerson.age}, ${updatedPerson.email}');

  final personNoEmail = person.copyWith(email: null);
  print('No email: ${personNoEmail.name}, ${personNoEmail.age}, ${personNoEmail.email}');
}