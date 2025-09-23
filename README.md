# Easy CopyWith

[![pub package](https://img.shields.io/pub/v/easy_copy_with.svg)](https://pub.dev/packages/easy_copy_with)
[![License](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

A lightweight Dart package for automatic generation of `copyWith` methods using the `@CopyWith` annotation.

## Features

- 🚀 Simple annotation-based API
- ⚡ Build-time code generation (no runtime overhead)
- 🔄 Supports nullable and non-nullable fields
- 🎯 Compatible with freezed patterns
- 📦 Minimal dependencies
- 🛠️ Easy integration with existing projects

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  easy_copy_with: ^1.0.0

dev_dependencies:
  build_runner: ^2.3.3
```

Then run:

```bash
dart pub get
```

## Quick Start

1. **Import the package:**

```dart
import 'package:easy_copy_with/easy_copy_with.dart';
```

2. **Add part directive:**

```dart
part 'your_file.copy_with.dart';
```

3. **Annotate your class:**

```dart
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
```

4. **Generate code:**

```bash
dart run build_runner build
```

5. **Use the generated copyWith method:**

```dart
final person = Person(name: 'John', age: 30);
final olderPerson = person.copyWith(age: 31);
```

## Example

```dart
import 'package:easy_copy_with/easy_copy_with.dart';

part 'user.copy_with.dart';

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
}

void main() {
  final user = User(name: 'Alice', age: 25);

  // Create copy with single field change
  final updatedUser = user.copyWith(age: 26);

  // Create copy with multiple field changes
  final activeUser = user.copyWith(
    email: 'alice@example.com',
    isActive: true,
  );

  print('Original: ${user.name}, ${user.age}');
  print('Updated: ${updatedUser.name}, ${updatedUser.age}');
}
```

## How It Works

The package uses `source_gen` and `build_runner` to analyze classes with the `@CopyWith` annotation and generate extension methods at build time.

### Code Generation Process

1. **Analysis**: The generator scans for classes annotated with `@CopyWith`
2. **Validation**: Ensures the class is not abstract and has a suitable constructor
3. **Field Detection**: Identifies all non-static, non-synthetic fields
4. **Extension Generation**: Creates a `copyWith` method as an extension

### Generated Code Structure

For the example above, the generated code looks like:

```dart
extension UserCopyWith on User {
  User copyWith({
    String? name,
    int? age,
    Object? email = const Object(),
    bool? isActive,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email == const Object() ? this.email : email as String?,
      isActive: isActive ?? this.isActive,
    );
  }
}
```

### Nullable Field Handling

The generator handles nullable and non-nullable fields differently:

- **Non-nullable fields** (e.g., `String name`): Parameter type becomes nullable (`String? name`) and uses null-coalescing operator (`??`)
- **Nullable fields** (e.g., `String? email`): Uses `Object?` parameter with sentinel value (`const Object()`) to distinguish between "don't change" and "set to null"

This approach allows you to explicitly set nullable fields to `null`:

```dart
// Set email to null
final userWithoutEmail = user.copyWith(email: null);

// Keep existing email value
final userSameEmail = user.copyWith(name: 'New Name');
```

### File Extensions

By default, generated files use the `.copy_with.dart` extension. You can customize this in your `build.yaml`:

```yaml
targets:
  $default:
    builders:
      easy_copy_with:copy_with:
        options:
          output_extension: ".g.dart"  # Use .g.dart instead
```

### Supported Class Types

The generator works with:
- ✅ Regular classes with named constructors
- ✅ Classes with generic type parameters
- ✅ Classes with nullable and non-nullable fields
- ❌ Abstract classes
- ❌ Classes without suitable constructors

## Commands

```bash
# Generate code once
dart run build_runner build

# Watch for changes and rebuild automatically
dart run build_runner watch

# Clean generated files
dart run build_runner clean
```

## Requirements

- Dart SDK: `>=3.9.2`
- Compatible with Flutter projects

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.
