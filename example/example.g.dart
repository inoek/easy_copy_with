// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'example.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AddressCopyWith on Address {
  Address copyWith({
    String? street,
    String? city,
    Object? postalCode = const Object(),
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      postalCode: postalCode == const Object()
          ? this.postalCode
          : postalCode as String?,
    );
  }
}

extension ContactInfoCopyWith on ContactInfo {
  ContactInfo copyWith({
    Object? email = const Object(),
    Object? phone = const Object(),
    Object? address = const Object(),
  }) {
    return ContactInfo(
      email: email == const Object() ? this.email : email as String?,
      phone: phone == const Object() ? this.phone : phone as String?,
      address: address == const Object() ? this.address : address as Address?,
    );
  }
}

extension PersonCopyWith on Person {
  Person copyWith({
    String? name,
    int? age,
    Object? contact = const Object(),
    Object? hobbies = const Object(),
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      contact: contact == const Object()
          ? this.contact
          : contact as ContactInfo?,
      hobbies: hobbies == const Object()
          ? this.hobbies
          : hobbies as List<String>?,
    );
  }
}

extension EmployeeCopyWith on Employee {
  Employee copyWith({
    String? id,
    Person? person,
    String? department,
    Object? salary = const Object(),
  }) {
    return Employee(
      id: id ?? this.id,
      person: person ?? this.person,
      department: department ?? this.department,
      salary: salary == const Object() ? this.salary : salary as double?,
    );
  }
}
