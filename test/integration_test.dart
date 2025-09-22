import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'integration_test.g.dart';

void main() {
  group('Integration Tests', () {
    group('Simple class with basic types', () {
      test('creates instance correctly', () {
        const person = Person(name: 'John', age: 30);

        expect(person.name, equals('John'));
        expect(person.age, equals(30));
      });

      test('copyWith changes single field', () {
        const person = Person(name: 'John', age: 30);
        final updated = person.copyWith(age: 31);

        expect(updated.name, equals('John'));
        expect(updated.age, equals(31));
        expect(person.age, equals(30));
      });

      test('copyWith changes multiple fields', () {
        const person = Person(name: 'John', age: 30);
        final updated = person.copyWith(name: 'Jane', age: 25);

        expect(updated.name, equals('Jane'));
        expect(updated.age, equals(25));
      });

      test('copyWith with no parameters returns equivalent instance', () {
        const person = Person(name: 'John', age: 30);
        final copy = person.copyWith();

        expect(copy.name, equals(person.name));
        expect(copy.age, equals(person.age));
        expect(copy == person, isFalse);
      });
    });

    group('Class with nullable fields', () {
      test('creates instance with nullable fields', () {
        const user = User(name: 'John', email: 'john@example.com');

        expect(user.name, equals('John'));
        expect(user.email, equals('john@example.com'));
        expect(user.age, isNull);
      });

      test('copyWith can set nullable field to non-null', () {
        const user = User(name: 'John');
        final updated = user.copyWith(email: 'john@example.com', age: 30);

        expect(updated.name, equals('John'));
        expect(updated.email, equals('john@example.com'));
        expect(updated.age, equals(30));
      });


      test('copyWith preserves null values when not specified', () {
        const user = User(name: 'John');
        final updated = user.copyWith(name: 'Jane');

        expect(updated.name, equals('Jane'));
        expect(updated.email, isNull);
        expect(updated.age, isNull);
      });
    });

    group('Class with complex types', () {
      test('creates instance with complex types', () {
        const config = Configuration(
          settings: {'theme': 'dark', 'language': 'en'},
          features: ['feature1', 'feature2'],
        );

        expect(config.settings, equals({'theme': 'dark', 'language': 'en'}));
        expect(config.features, equals(['feature1', 'feature2']));
        expect(config.metadata, isNull);
      });

      test('copyWith works with complex types', () {
        const config = Configuration(
          settings: {'theme': 'dark'},
          features: ['feature1'],
        );

        final updated = config.copyWith(
          settings: {'theme': 'light', 'language': 'es'},
          metadata: {'version': '1.0'},
        );

        expect(updated.settings, equals({'theme': 'light', 'language': 'es'}));
        expect(updated.features, equals(['feature1']));
        expect(updated.metadata, equals({'version': '1.0'}));
      });

      test('copyWith preserves complex type references', () {
        final originalSettings = {'theme': 'dark'};
        final originalFeatures = ['feature1'];

        final config = Configuration(
          settings: originalSettings,
          features: originalFeatures,
        );

        final updated = config.copyWith(metadata: {'new': 'data'});

        expect(updated.settings, same(originalSettings));
        expect(updated.features, same(originalFeatures));
      });
    });

    group('Immutability guarantees', () {
      test('original instance is not modified by copyWith', () {
        const original = Person(name: 'John', age: 30);
        final copy = original.copyWith(name: 'Jane', age: 25);

        expect(original.name, equals('John'));
        expect(original.age, equals(30));
        expect(copy.name, equals('Jane'));
        expect(copy.age, equals(25));
      });

      test('multiple copyWith calls do not affect each other', () {
        const base = Person(name: 'John', age: 30);
        final copy1 = base.copyWith(name: 'Jane');
        final copy2 = base.copyWith(age: 25);

        expect(base.name, equals('John'));
        expect(base.age, equals(30));
        expect(copy1.name, equals('Jane'));
        expect(copy1.age, equals(30));
        expect(copy2.name, equals('John'));
        expect(copy2.age, equals(25));
      });
    });

    group('Type safety', () {
      test('copyWith preserves types correctly', () {
        const person = Person(name: 'John', age: 30);
        final copy = person.copyWith(age: 25);

        expect(copy, isA<Person>());
        expect(copy.name, isA<String>());
        expect(copy.age, isA<int>());
      });

      test('copyWith with nullable types preserves nullability', () {
        const user = User(name: 'John');
        final copy = user.copyWith(email: 'test@example.com');

        expect(copy, isA<User>());
        expect(copy.name, isA<String>());
        expect(copy.email, isA<String?>());
        expect(copy.age, isA<int?>());
      });
    });
  });
}

@CopyWith()
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });
}

@CopyWith()
class User {
  final String name;
  final String? email;
  final int? age;

  const User({
    required this.name,
    this.email,
    this.age,
  });
}

@CopyWith()
class Configuration {
  final Map<String, String> settings;
  final List<String> features;
  final Map<String, dynamic>? metadata;

  const Configuration({
    required this.settings,
    required this.features,
    this.metadata,
  });
}