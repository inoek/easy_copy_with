# Easy CopyWith

[![pub package](https://img.shields.io/pub/v/easy_copy_with.svg)](https://pub.dev/packages/easy_copy_with)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A lightweight Dart package for automatic generation of `copyWith` methods using the `@CopyWith` annotation.

## Features

- 🚀 Simple annotation-based API
- ⚡ Build-time code generation (no runtime overhead)
- 🔄 Supports nullable and non-nullable fields
- 🎯 Compatible with correct type handling
- 📦 Minimal dependencies
- 🛠️ Easy integration with existing projects

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  easy_copy_with: ^3.2.0

dev_dependencies:
  build_runner: ^2.10.4
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
part 'your_file.g.dart';
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

part 'example.g.dart';

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
  const user = User(
    name: 'Alice',
    age: 25,
    email: 'alice@example.com',
  );

  final older = user.copyWith(age: 26);
  final renamed = older.copyWith(name: 'Alicia');
  final withoutEmail = renamed.copyWith(email: null);

  print(user);
  print(older);
  print(renamed);
  print(withoutEmail);
}
```

You can run the complete working sample with `dart run example/example.dart`.

## Sealed Classes Support

Starting from version 3.1.0, `easy_copy_with` supports `sealed` classes. The generator creates `copyWith` methods for each subclass defined in the sealed class hierarchy.

```dart
@CopyWith()
sealed class Result {
  const factory Result.success({required String value}) = Success;
  const factory Result.error({required String message}) = Error;
  
  const Result._();
}

final class Success extends Result {
  final String value;
  const Success({required this.value}) : super._();
}

final class Error extends Result {
  final String message;
  const Error({required this.message}) : super._();
}
```

You can then use `copyWith` on the specific subtypes:

```dart
void main() {
  Result result = Success(value: 'Initial');
  
  if (result is Success) {
    // The copyWith method is available on the casted type
    final updated = result.copyWith(value: 'Updated'); 
  }
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
typedef UserCopyWithFn =
    User Function({String? name, int? age, String? email, bool? isActive});

const Object _userCopyWithPlaceholder = Object();

extension UserCopyWith on User {
  UserCopyWithFn get copyWith {
    final instance = this;
    User copyWithFn({
      Object? name = _userCopyWithPlaceholder,
      Object? age = _userCopyWithPlaceholder,
      Object? email = _userCopyWithPlaceholder,
      Object? isActive = _userCopyWithPlaceholder,
    }) {
      return User(
        name: identical(name, _userCopyWithPlaceholder) || name == null
            ? instance.name
            : name as String,
        age: identical(age, _userCopyWithPlaceholder) || age == null
            ? instance.age
            : age as int,
        email: identical(email, _userCopyWithPlaceholder)
            ? instance.email
            : email as String?,
        isActive:
            identical(isActive, _userCopyWithPlaceholder) || isActive == null
            ? instance.isActive
            : isActive as bool,
      );
    }

    return copyWithFn as UserCopyWithFn;
  }
}
```

### Nullable Field Handling

The generator handles nullable and non-nullable fields differently:

- **Non-nullable fields** (e.g., `String name`): Parameters remain type-safe (`String? name`) while still preventing unintended null assignment in the generated body.
- **Nullable fields** (e.g., `String? email`): Internally use a sentinel value to distinguish between "don't change" and "set to null", allowing you to pass `null` explicitly.

This approach allows you to explicitly set nullable fields to `null`:

```dart
// Set email to null
final userWithoutEmail = user.copyWith(email: null);

// Keep existing email value
final userSameEmail = user.copyWith(name: 'New Name');
```

### File Extensions

By default, generated files use the `.g.dart` extension, so the generated code happily shares the same part file with other `source_gen` builders (for example `json_serializable` or `freezed`).

If you prefer to keep a dedicated `.copy_with.dart` file, override the builder configuration in your project’s `build.yaml`:

```yaml
targets:
  $default:
    builders:
      easy_copy_with:copy_with:
        options:
          output_extension: ".copy_with.dart"  # Use .copy_with.dart instead

builders:
  easy_copy_with:copy_with:
    import: "package:easy_copy_with/src/builder.dart"
    builder_factories: ["copyWithBuilder"]
    build_extensions: {".dart": [".copy_with.dart"]}
    auto_apply: dependents
    build_to: source
```

### Supported Class Types

The generator works with:
- ✅ Regular classes with named constructors
- ✅ Classes with generic type parameters
- ✅ Classes with nullable and non-nullable fields
- ✅ Sealed classes (subclasses)
- ❌ Abstract classes (except sealed classes)
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

- Dart SDK: `>=3.10.0`
- Compatible with Flutter projects

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.
