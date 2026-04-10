import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart';

/// Annotate your class with `@CopyWith()` and run `build_runner`
/// to generate a type-safe `copyWith` method.
///
/// Generated part file omitted — see the `easy_copy_with` package
/// for a full working example with `build_runner`.
///
/// ```bash
/// dart run build_runner build
/// ```
///
/// After code generation:
/// ```dart
/// final user = User(name: 'Alice', age: 25);
/// final updated = user.copyWith(age: 26);
/// final cleared = user.copyWith(email: null);
/// ```
@CopyWith()
class User {
  final String name;
  final int age;
  final String? email;

  const User({required this.name, required this.age, this.email});
}
