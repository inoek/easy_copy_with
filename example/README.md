# Easy CopyWith Example

Этот пример демонстрирует использование пакета `easy_copy_with`.

## Запуск примера

```bash
# Установить зависимости
dart pub get

# Сгенерировать код
dart run build_runner build

# Запустить примеры
dart run example.dart
dart run simple_test.dart
```

## Файлы

- `example.dart` - полный пример с двумя классами (Person и Address)
- `simple_test.dart` - простой пример с одним классом
- `pubspec.yaml` - зависимости для примера
- `build.yaml` - конфигурация генератора

## Как это работает

1. Добавьте аннотацию `@CopyWith()` к классу
2. Добавьте `part 'filename.g.dart';` директиву
3. Запустите `dart run build_runner build`
4. Используйте сгенерированный метод `copyWith()`

## Сгенерированный код

Генератор создает extension методы для каждого класса с аннотацией `@CopyWith()`:

```dart
extension PersonCopyWith on Person {
  Person copyWith({
    String? name,
    int? age,
    String? email,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }
}
```