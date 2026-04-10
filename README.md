# Easy CopyWith

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Automatic generation of `copyWith` methods for Dart classes.

## Packages

| Package | Description | pub.dev |
|---------|-------------|---------|
| [easy_copy_with](easy_copy_with/) | Code generator | [![pub](https://img.shields.io/pub/v/easy_copy_with.svg)](https://pub.dev/packages/easy_copy_with) |
| [easy_copy_with_annotation](easy_copy_with_annotation/) | `@CopyWith` annotation | [![pub](https://img.shields.io/pub/v/easy_copy_with_annotation.svg)](https://pub.dev/packages/easy_copy_with_annotation) |

## Quick Start

```yaml
dependencies:
  easy_copy_with_annotation: ^1.0.0

dev_dependencies:
  easy_copy_with: ^4.0.0
  build_runner: ^2.10.4
```

```dart
import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart';

part 'user.g.dart';

@CopyWith()
class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}
```

```bash
dart run build_runner build
```

See [easy_copy_with/README.md](easy_copy_with/README.md) for full documentation.

## License

MIT
