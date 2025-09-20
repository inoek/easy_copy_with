import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'simple_test.g.dart';

void main() {
  group('Simple CopyWith Tests', () {
    test('basic functionality works', () {
      const person = TestPerson(name: 'John', age: 30);
      final updated = person.copyWith(age: 31);

      expect(updated.name, equals('John'));
      expect(updated.age, equals(31));
      expect(person.age, equals(30)); // Original unchanged
    });

    test('multiple field changes work', () {
      const person = TestPerson(name: 'John', age: 30);
      final updated = person.copyWith(name: 'Jane', age: 25);

      expect(updated.name, equals('Jane'));
      expect(updated.age, equals(25));
    });

    test('no parameters returns equivalent instance', () {
      const person = TestPerson(name: 'John', age: 30);
      final copy = person.copyWith();

      expect(copy.name, equals(person.name));
      expect(copy.age, equals(person.age));
    });

    test('preserves immutability', () {
      const original = TestPerson(name: 'John', age: 30);
      final copy = original.copyWith(name: 'Jane');

      expect(original.name, equals('John'));
      expect(copy.name, equals('Jane'));
    });

    test('works with nullable fields', () {
      const user = TestUser(name: 'John');
      final updated = user.copyWith(email: 'john@example.com');

      expect(updated.name, equals('John'));
      expect(updated.email, equals('john@example.com'));
      expect(user.email, isNull);
    });
  });
}

@CopyWith()
class TestPerson {
  final String name;
  final int age;

  const TestPerson({
    required this.name,
    required this.age,
  });
}

@CopyWith()
class TestUser {
  final String name;
  final String? email;

  const TestUser({
    required this.name,
    this.email,
  });
}