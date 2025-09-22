import 'package:easy_copy_with/easy_copy_with.dart';

part 'example.g.dart';

void main() {
  print('=== Easy CopyWith Example ===\n');

  const address = Address(
    street: '123 Main St',
    city: 'New York',
    postalCode: '10001',
  );

  const contact = ContactInfo(
    email: 'john@example.com',
    phone: '+1-555-0123',
    address: address,
  );

  const person = Person(
    name: 'John Doe',
    age: 30,
    contact: contact,
    hobbies: ['reading', 'coding', 'hiking'],
  );

  const employee = Employee(
    id: 'EMP001',
    person: person,
    department: 'Engineering',
    salary: 75000.0,
  );

  print('1. Original employee:');
  print(employee);
  print('');

  print('2. Update age and salary:');
  final olderEmployee = employee.copyWith(
    person: employee.person.copyWith(
      name: 'John Doe',
      age: 31,
    ),
    salary: 80000.0,
  );
  print(olderEmployee);
  print('');

  print('3. Update contact info (nested object):');
  final updatedEmployee = olderEmployee.copyWith(
    person: olderEmployee.person.copyWith(
      name: 'John Doe',
      age: 31,
      contact: olderEmployee.person.contact?.copyWith(
        email: 'john.doe@company.com',
        phone: '+1-555-9999',
      ),
    ),
  );
  print(updatedEmployee);
  print('');

  print('4. Remove optional fields (set to null):');
  final minimalEmployee = updatedEmployee.copyWith(
    person: updatedEmployee.person.copyWith(
      name: 'John Doe',
      age: 31,
      contact: updatedEmployee.person.contact?.copyWith(
        phone: null,
        address: null,
      ),
      hobbies: null,
    ),
    salary: null,
  );
  print(minimalEmployee);
  print('');

  print('5. Update address while keeping other contact info:');
  const newAddress = Address(
    street: '456 Oak Ave',
    city: 'San Francisco',
    postalCode: '94102',
  );

  final relocatedEmployee = minimalEmployee.copyWith(
    person: minimalEmployee.person.copyWith(
      name: 'John Doe',
      age: 31,
      contact: ContactInfo(
        email: minimalEmployee.person.contact?.email,
        phone: '+1-415-555-0123',
        address: newAddress,
      ),
    ),
  );
  print(relocatedEmployee);
  print('');

  print('6. Working with nullable fields:');
  print('Original contact email: ${employee.person.contact?.email}');
  print('Minimal contact email: ${minimalEmployee.person.contact?.email}');
  print('Relocated contact email: ${relocatedEmployee.person.contact?.email}');
  print('');

  print('7. Parameter types demonstration:');
  print('- Named required: Person(name: "Name", age: 30)');
  print('- Named required: Employee(id: "...", person: ..., department: "...")');
  print('- Named optional: Employee(..., salary: 123.45)');
  print('- Nullable: ContactInfo(email: null, phone: null, address: null)');
}

@CopyWith()
class Address {
  final String street;
  final String city;
  final String? postalCode;

  const Address({
    required this.street,
    required this.city,
    this.postalCode,
  });

  @override
  String toString() => 'Address(street: $street, city: $city, postalCode: $postalCode)';
}

@CopyWith()
class ContactInfo {
  final String? email;
  final String? phone;
  final Address? address;

  const ContactInfo({
    this.email,
    this.phone,
    this.address,
  });

  @override
  String toString() => 'ContactInfo(email: $email, phone: $phone, address: $address)';
}

@CopyWith()
class Person {
  final String name;
  final int age;
  final ContactInfo? contact;
  final List<String>? hobbies;

  const Person({
    required this.name,
    required this.age,
    this.contact,
    this.hobbies,
  });

  @override
  String toString() => 'Person(name: $name, age: $age, contact: $contact, hobbies: $hobbies)';
}

@CopyWith()
class Employee {
  final String id;
  final Person person;
  final String department;
  final double? salary;

  const Employee({
    required this.id,
    required this.person,
    required this.department,
    this.salary,
  });

  @override
  String toString() => 'Employee(id: $id, person: $person, department: $department, salary: $salary)';
}

