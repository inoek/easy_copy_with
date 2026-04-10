# easy_copy_with_annotation

[![pub package](https://img.shields.io/pub/v/easy_copy_with_annotation.svg)](https://pub.dev/packages/easy_copy_with_annotation)

Annotations for the [easy_copy_with](https://pub.dev/packages/easy_copy_with) code generator.

## Usage

Add `easy_copy_with_annotation` as a dependency and `easy_copy_with` as a dev dependency:

```yaml
dependencies:
  easy_copy_with_annotation: ^1.0.0

dev_dependencies:
  easy_copy_with: ^4.0.0
  build_runner: ^2.10.4
```

Annotate your classes:

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

See the [easy_copy_with](https://pub.dev/packages/easy_copy_with) package for full documentation.
