# Easy CopyWith Example

Этот пример демонстрирует использование пакета `easy_copy_with`.

## Запуск примера

```bash
dart pub get
dart run example.dart
```

## Файлы

- `example.dart` — готовый к запуску пример с классом `User`
- `pubspec.yaml` - зависимости для примера
- `build.yaml` - конфигурация генератора

## Как это работает

1. Добавьте аннотацию `@CopyWith()` к классу
2. Добавьте `part 'filename.g.dart';` директиву
3. Запустите `dart run build_runner build`
4. Используйте сгенерированный метод `copyWith()`

## Сгенерированный код

Генератор создает расширения, которые позволяют безопасно обновлять поля:

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

Код выше упрощен, полный вариант доступен в `example.g.dart`.
