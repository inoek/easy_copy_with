import 'package:easy_copy_with/easy_copy_with.dart';

part 'example.g.dart';

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

@CopyWith()
class Address {
  final String street;
  final String city;
  final String country;
  final String? postalCode;

  const Address({
    required this.street,
    required this.city,
    required this.country,
    this.postalCode,
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
    email: null,
  );

  print('Original: ${person.name}, ${person.age}, ${person.email}');
  print('Updated: ${updatedPerson.name}, ${updatedPerson.age}, ${updatedPerson.email}');

  const address = Address(
    street: '123 Main St',
    city: 'New York',
    country: 'USA',
  );

  final updatedAddress = address.copyWith(
    postalCode: '10001',
  );

  print('Original address: ${address.street}, ${address.city}, ${address.postalCode}');
  print('Updated address: ${updatedAddress.street}, ${updatedAddress.city}, ${updatedAddress.postalCode}');
}