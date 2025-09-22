import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'null_assignment_test.g.dart';

void main() {
  group('Null Assignment Test', () {
    test('should assign null when variable is null', () {
      const model = TestModel(
        name: 'John',
        email: 'john@example.com',
        age: 30,
      );

      const String? nullValue = null;
      const int? nullAge = null;

      final updated = model.copyWith(
        email: nullValue,
        age: nullAge,
      );

      expect(updated.name, equals('John'));
      expect(updated.email, isNull);
      expect(updated.age, isNull);

      expect(model.email, equals('john@example.com'));
      expect(model.age, equals(30));
    });

    test('should assign null with direct null assignment', () {
      const model = TestModel(
        name: 'Jane',
        email: 'jane@example.com',
        age: 25,
      );

      final updated = model.copyWith(
        email: null,
        age: null,
      );

      expect(updated.name, equals('Jane'));
      expect(updated.email, isNull);
      expect(updated.age, isNull);
    });

    test('should work with mixed null and non-null values', () {
      const model = TestModel(
        name: 'Bob',
        email: 'bob@example.com',
        age: 40,
      );

      const String? nullEmail = null;
      const int newAge = 41;

      final updated = model.copyWith(
        email: nullEmail,
        age: newAge,
      );

      expect(updated.name, equals('Bob'));
      expect(updated.email, isNull);
      expect(updated.age, equals(41));
    });

    test('should preserve existing null values', () {
      const model = TestModel(
        name: 'Alice',
      );

      final updated = model.copyWith(
        name: 'Alice Updated',
      );

      expect(updated.name, equals('Alice Updated'));
      expect(updated.email, isNull);
      expect(updated.age, isNull);
    });
  });
}

@CopyWith()
class TestModel {
  final String name;
  final String? email;
  final int? age;

  const TestModel({
    required this.name,
    this.email,
    this.age,
  });
}