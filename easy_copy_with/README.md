# easy_copy_with

[![pub package](https://img.shields.io/pub/v/easy_copy_with.svg)](https://pub.dev/packages/easy_copy_with)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Code generator for automatic `copyWith` methods in Dart classes using the `@CopyWith` annotation from [easy_copy_with_annotation](https://pub.dev/packages/easy_copy_with_annotation).

## Installation

```yaml
dependencies:
  easy_copy_with_annotation: ^1.0.0

dev_dependencies:
  easy_copy_with: ^4.0.0
  build_runner: ^2.10.4
```

## Quick Start

```dart
import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart';

part 'user.g.dart';

@CopyWith()
class User {
  final String name;
  final int age;
  final String? email;

  const User({required this.name, required this.age, this.email});
}
```

Generate code:

```bash
dart run build_runner build
```

Use:

```dart
final user = User(name: 'John', age: 30);
final olderUser = user.copyWith(age: 31);
final withoutEmail = user.copyWith(email: null); // nullable fields supported
```

## Features

- Annotation-based API
- Build-time code generation (no runtime overhead)
- Supports nullable and non-nullable fields
- Supports generic type parameters
- Supports sealed classes
- Supports named constructors

## Sealed Classes

```dart
@CopyWith()
sealed class Role {
  const factory Role.admin({required int adminLevel}) = Admin;
  const factory Role.userRole({required String username}) = UserRole;
  const Role._();
}

final class Admin extends Role {
  final int adminLevel;
  const Admin({required this.adminLevel}) : super._();
}

final class UserRole extends Role {
  final String username;
  const UserRole({required this.username}) : super._();
}
```

## Migration from 3.x

1. Add `easy_copy_with_annotation: ^1.0.0` to `dependencies`
2. Move `easy_copy_with` to `dev_dependencies`
3. Replace imports:
   - `import 'package:easy_copy_with/annotations.dart'` -> `import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart'`
   - `import 'package:easy_copy_with/easy_copy_with.dart'` -> `import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart'`

## License

MIT
