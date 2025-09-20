// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'example.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PersonCopyWith on Person {
  Person copyWith({String? name, int? age, Object? email = const Object()}) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email == const Object() ? this.email : email as String?,
    );
  }
}

extension AddressCopyWith on Address {
  Address copyWith({
    String? street,
    String? city,
    String? country,
    Object? postalCode = const Object(),
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      postalCode: postalCode == const Object()
          ? this.postalCode
          : postalCode as String?,
    );
  }
}
