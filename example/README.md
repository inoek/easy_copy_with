# Easy CopyWith Example

This example demonstrates how to use the `easy_copy_with` package.

## Quick Start

Run every command from the `example/` directory.

1. Install dependencies:
   ```bash
   dart pub get
   ```
2. Generate the code (produces `lib/user.g.dart`):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. Run the sample:
   ```bash
   dart run example.dart
   ```

## Files

- `example.dart` — executable sample that uses the `User` class
- `lib/user.dart` — source model annotated with `@CopyWith`
- `lib/user.g.dart` — generated `copyWith` extension
- `pubspec.yaml` — example dependencies
- `build.yaml` — minimal builder configuration

## How It Works

1. Add the `@CopyWith()` annotation to a class
2. Add the `part 'filename.g.dart';` directive next to the class declaration
3. Run `dart run build_runner build`
4. Use the generated `copyWith()` method

## Generated Code

The generator creates extensions that let you safely update fields:

```dart
typedef UserCopyWithFn =
    User Function({String? name, int? age, String? email, bool? isActive});

extension UserCopyWith on User {
  UserCopyWithFn get copyWith => _copyWith;

  UserCopyWithFn _copyWith({
    Object? name = _userCopyWithPlaceholder,
    Object? age = _userCopyWithPlaceholder,
    Object? email = _userCopyWithPlaceholder,
    Object? isActive = _userCopyWithPlaceholder,
  }) {
    // ...
  }
}
```

The snippet above is trimmed for brevity; the full version lives in `lib/user.g.dart`.
