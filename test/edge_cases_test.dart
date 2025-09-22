import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'edge_cases_test.g.dart';

void main() {
  group('Edge Cases', () {
    group('Single field classes', () {
      test('class with single String field', () {
        const item = SingleString(value: 'test');
        final updated = item.copyWith(value: 'updated');

        expect(updated.value, equals('updated'));
        expect(item.value, equals('test'));
      });

      test('class with single nullable field', () {
        const item = SingleNullable();
        final updated = item.copyWith(value: 'not null');

        expect(updated.value, equals('not null'));
        expect(item.value, isNull);
      });

      test('class with single bool field', () {
        const item = SingleBool(flag: false);
        final updated = item.copyWith(flag: true);

        expect(updated.flag, isTrue);
        expect(item.flag, isFalse);
      });
    });

    group('Special type handling', () {
      test('handles DateTime correctly', () {
        final now = DateTime.now();
        final later = now.add(const Duration(hours: 1));

        final event = TimestampedEvent(timestamp: now, message: 'test');
        final updated = event.copyWith(timestamp: later);

        expect(updated.timestamp, equals(later));
        expect(updated.message, equals('test'));
        expect(event.timestamp, equals(now));
      });

      test('handles Duration correctly', () {
        const duration1 = Duration(minutes: 30);
        const duration2 = Duration(hours: 1);

        const task = TaskWithDuration(duration: duration1, name: 'task');
        final updated = task.copyWith(duration: duration2);

        expect(updated.duration, equals(duration2));
        expect(updated.name, equals('task'));
        expect(task.duration, equals(duration1));
      });

      test('handles Uri correctly', () {
        final uri1 = Uri.parse('https://example.com');
        final uri2 = Uri.parse('https://other.com');

        final link = LinkData(url: uri1, title: 'Example');
        final updated = link.copyWith(url: uri2);

        expect(updated.url, equals(uri2));
        expect(updated.title, equals('Example'));
        expect(link.url, equals(uri1));
      });

      test('handles enums correctly', () {
        const status1 = Status.pending;
        const status2 = Status.completed;

        const task = TaskStatus(status: status1, name: 'Task 1');
        final updated = task.copyWith(status: status2);

        expect(updated.status, equals(status2));
        expect(updated.name, equals('Task 1'));
        expect(task.status, equals(status1));
      });
    });

    group('Collection handling', () {
      test('handles List<String>', () {
        const original = ['a', 'b', 'c'];
        const updated = ['x', 'y', 'z'];

        const container = StringList(items: original);
        final copy = container.copyWith(items: updated);

        expect(copy.items, equals(updated));
        expect(container.items, equals(original));
      });

      test('handles Map<String, int>', () {
        const original = {'a': 1, 'b': 2};
        const updated = {'x': 10, 'y': 20};

        const container = StringIntMap(data: original);
        final copy = container.copyWith(data: updated);

        expect(copy.data, equals(updated));
        expect(container.data, equals(original));
      });

      test('handles Set<int>', () {
        const original = {1, 2, 3};
        const updated = {10, 20, 30};

        const container = IntSet(numbers: original);
        final copy = container.copyWith(numbers: updated);

        expect(copy.numbers, equals(updated));
        expect(container.numbers, equals(original));
      });

      test('handles nested collections', () {
        const original = [
          {'key1': 'value1'},
          {'key2': 'value2'}
        ];
        const updated = [
          {'key3': 'value3'}
        ];

        const container = NestedCollection(data: original);
        final copy = container.copyWith(data: updated);

        expect(copy.data, equals(updated));
        expect(container.data, equals(original));
      });
    });

    group('Null safety edge cases', () {
      test('setting null to nullable field works', () {
        const item = NullableFields(required: 'test', optional: 'value');
        final updated = item.copyWith(optional: null);

        expect(updated.required, equals('test'));
        expect(updated.optional, isNull);
        expect(item.optional, equals('value'));
      });

      test('null ?? null returns null for nullable fields', () {
        const item = NullableFields(required: 'test');
        final copy = item.copyWith();

        expect(copy.required, equals('test'));
        expect(copy.optional, isNull);
        expect(item.optional, isNull);
      });

      test('explicit null overwrites existing value', () {
        const item = NullableFields(required: 'test', optional: 'existing');
        final updated = item.copyWith(optional: null);

        expect(updated.optional, isNull);
        expect(item.optional, equals('existing'));
      });
    });

    group('Performance and memory', () {
      test('copyWith does not create unnecessary copies', () {
        const original = LargeObject(
          data1: 'large string data that takes memory',
          data2: 42,
          data3: true,
        );

        final copy = original.copyWith(data2: 43);

        expect(copy.data1, same(original.data1));
        expect(copy.data3, same(original.data3));
        expect(copy.data2, equals(43));
        expect(original.data2, equals(42));
      });

      test('works with many fields', () {
        const original = ManyFields(
          field1: 'value1',
          field2: 'value2',
          field3: 'value3',
          field4: 'value4',
          field5: 'value5',
          field6: 6,
          field7: 7,
          field8: 8,
          field9: 9,
          field10: 10,
        );

        final updated = original.copyWith(
          field5: 'updated5',
          field8: 80,
        );

        expect(updated.field1, equals('value1'));
        expect(updated.field5, equals('updated5'));
        expect(updated.field8, equals(80));
        expect(updated.field10, equals(10));
      });
    });


  });
}


@CopyWith()
class SingleString {
  final String value;
  const SingleString({required this.value});
}

@CopyWith()
class SingleNullable {
  final String? value;
  const SingleNullable({this.value});
}

@CopyWith()
class SingleBool {
  final bool flag;
  const SingleBool({required this.flag});
}

@CopyWith()
class TimestampedEvent {
  final DateTime timestamp;
  final String message;
  const TimestampedEvent({required this.timestamp, required this.message});
}

@CopyWith()
class TaskWithDuration {
  final Duration duration;
  final String name;
  const TaskWithDuration({required this.duration, required this.name});
}

@CopyWith()
class LinkData {
  final Uri url;
  final String title;
  const LinkData({required this.url, required this.title});
}

enum Status { pending, inProgress, completed }

@CopyWith()
class TaskStatus {
  final Status status;
  final String name;
  const TaskStatus({required this.status, required this.name});
}

@CopyWith()
class StringList {
  final List<String> items;
  const StringList({required this.items});
}

@CopyWith()
class StringIntMap {
  final Map<String, int> data;
  const StringIntMap({required this.data});
}

@CopyWith()
class IntSet {
  final Set<int> numbers;
  const IntSet({required this.numbers});
}

@CopyWith()
class NestedCollection {
  final List<Map<String, String>> data;
  const NestedCollection({required this.data});
}

@CopyWith()
class NullableFields {
  final String required;
  final String? optional;
  const NullableFields({required this.required, this.optional});
}

@CopyWith()
class LargeObject {
  final String data1;
  final int data2;
  final bool data3;
  const LargeObject({
    required this.data1,
    required this.data2,
    required this.data3,
  });
}

@CopyWith()
class ManyFields {
  final String field1;
  final String field2;
  final String field3;
  final String field4;
  final String field5;
  final int field6;
  final int field7;
  final int field8;
  final int field9;
  final int field10;

  const ManyFields({
    required this.field1,
    required this.field2,
    required this.field3,
    required this.field4,
    required this.field5,
    required this.field6,
    required this.field7,
    required this.field8,
    required this.field9,
    required this.field10,
  });
}

