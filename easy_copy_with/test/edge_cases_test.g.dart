// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_cases_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef SingleStringCopyWithFn = SingleString Function({String value});

const Object _singleStringCopyWithPlaceholder = Object();

extension SingleStringCopyWith on SingleString {
  SingleStringCopyWithFn get copyWith {
    final instance = this;
    SingleString copyWithFn({Object value = _singleStringCopyWithPlaceholder}) {
      return SingleString(
        value: identical(value, _singleStringCopyWithPlaceholder)
            ? instance.value
            : value as String,
      );
    }

    return copyWithFn as SingleStringCopyWithFn;
  }
}

typedef SingleNullableCopyWithFn = SingleNullable Function({String? value});

const Object _singleNullableCopyWithPlaceholder = Object();

extension SingleNullableCopyWith on SingleNullable {
  SingleNullableCopyWithFn get copyWith {
    final instance = this;
    SingleNullable copyWithFn({
      Object? value = _singleNullableCopyWithPlaceholder,
    }) {
      return SingleNullable(
        value: identical(value, _singleNullableCopyWithPlaceholder)
            ? instance.value
            : value as String?,
      );
    }

    return copyWithFn as SingleNullableCopyWithFn;
  }
}

typedef SingleBoolCopyWithFn = SingleBool Function({bool flag});

const Object _singleBoolCopyWithPlaceholder = Object();

extension SingleBoolCopyWith on SingleBool {
  SingleBoolCopyWithFn get copyWith {
    final instance = this;
    SingleBool copyWithFn({Object flag = _singleBoolCopyWithPlaceholder}) {
      return SingleBool(
        flag: identical(flag, _singleBoolCopyWithPlaceholder)
            ? instance.flag
            : flag as bool,
      );
    }

    return copyWithFn as SingleBoolCopyWithFn;
  }
}

typedef TimestampedEventCopyWithFn =
    TimestampedEvent Function({DateTime timestamp, String message});

const Object _timestampedEventCopyWithPlaceholder = Object();

extension TimestampedEventCopyWith on TimestampedEvent {
  TimestampedEventCopyWithFn get copyWith {
    final instance = this;
    TimestampedEvent copyWithFn({
      Object timestamp = _timestampedEventCopyWithPlaceholder,
      Object message = _timestampedEventCopyWithPlaceholder,
    }) {
      return TimestampedEvent(
        timestamp: identical(timestamp, _timestampedEventCopyWithPlaceholder)
            ? instance.timestamp
            : timestamp as DateTime,
        message: identical(message, _timestampedEventCopyWithPlaceholder)
            ? instance.message
            : message as String,
      );
    }

    return copyWithFn as TimestampedEventCopyWithFn;
  }
}

typedef TaskWithDurationCopyWithFn =
    TaskWithDuration Function({Duration duration, String name});

const Object _taskWithDurationCopyWithPlaceholder = Object();

extension TaskWithDurationCopyWith on TaskWithDuration {
  TaskWithDurationCopyWithFn get copyWith {
    final instance = this;
    TaskWithDuration copyWithFn({
      Object duration = _taskWithDurationCopyWithPlaceholder,
      Object name = _taskWithDurationCopyWithPlaceholder,
    }) {
      return TaskWithDuration(
        duration: identical(duration, _taskWithDurationCopyWithPlaceholder)
            ? instance.duration
            : duration as Duration,
        name: identical(name, _taskWithDurationCopyWithPlaceholder)
            ? instance.name
            : name as String,
      );
    }

    return copyWithFn as TaskWithDurationCopyWithFn;
  }
}

typedef LinkDataCopyWithFn = LinkData Function({Uri url, String title});

const Object _linkDataCopyWithPlaceholder = Object();

extension LinkDataCopyWith on LinkData {
  LinkDataCopyWithFn get copyWith {
    final instance = this;
    LinkData copyWithFn({
      Object url = _linkDataCopyWithPlaceholder,
      Object title = _linkDataCopyWithPlaceholder,
    }) {
      return LinkData(
        url: identical(url, _linkDataCopyWithPlaceholder)
            ? instance.url
            : url as Uri,
        title: identical(title, _linkDataCopyWithPlaceholder)
            ? instance.title
            : title as String,
      );
    }

    return copyWithFn as LinkDataCopyWithFn;
  }
}

typedef TaskStatusCopyWithFn =
    TaskStatus Function({Status status, String name});

const Object _taskStatusCopyWithPlaceholder = Object();

extension TaskStatusCopyWith on TaskStatus {
  TaskStatusCopyWithFn get copyWith {
    final instance = this;
    TaskStatus copyWithFn({
      Object status = _taskStatusCopyWithPlaceholder,
      Object name = _taskStatusCopyWithPlaceholder,
    }) {
      return TaskStatus(
        status: identical(status, _taskStatusCopyWithPlaceholder)
            ? instance.status
            : status as Status,
        name: identical(name, _taskStatusCopyWithPlaceholder)
            ? instance.name
            : name as String,
      );
    }

    return copyWithFn as TaskStatusCopyWithFn;
  }
}

typedef StringListCopyWithFn = StringList Function({List<String> items});

const Object _stringListCopyWithPlaceholder = Object();

extension StringListCopyWith on StringList {
  StringListCopyWithFn get copyWith {
    final instance = this;
    StringList copyWithFn({Object items = _stringListCopyWithPlaceholder}) {
      return StringList(
        items: identical(items, _stringListCopyWithPlaceholder)
            ? instance.items
            : items as List<String>,
      );
    }

    return copyWithFn as StringListCopyWithFn;
  }
}

typedef StringIntMapCopyWithFn = StringIntMap Function({Map<String, int> data});

const Object _stringIntMapCopyWithPlaceholder = Object();

extension StringIntMapCopyWith on StringIntMap {
  StringIntMapCopyWithFn get copyWith {
    final instance = this;
    StringIntMap copyWithFn({Object data = _stringIntMapCopyWithPlaceholder}) {
      return StringIntMap(
        data: identical(data, _stringIntMapCopyWithPlaceholder)
            ? instance.data
            : data as Map<String, int>,
      );
    }

    return copyWithFn as StringIntMapCopyWithFn;
  }
}

typedef IntSetCopyWithFn = IntSet Function({Set<int> numbers});

const Object _intSetCopyWithPlaceholder = Object();

extension IntSetCopyWith on IntSet {
  IntSetCopyWithFn get copyWith {
    final instance = this;
    IntSet copyWithFn({Object numbers = _intSetCopyWithPlaceholder}) {
      return IntSet(
        numbers: identical(numbers, _intSetCopyWithPlaceholder)
            ? instance.numbers
            : numbers as Set<int>,
      );
    }

    return copyWithFn as IntSetCopyWithFn;
  }
}

typedef NestedCollectionCopyWithFn =
    NestedCollection Function({List<Map<String, String>> data});

const Object _nestedCollectionCopyWithPlaceholder = Object();

extension NestedCollectionCopyWith on NestedCollection {
  NestedCollectionCopyWithFn get copyWith {
    final instance = this;
    NestedCollection copyWithFn({
      Object data = _nestedCollectionCopyWithPlaceholder,
    }) {
      return NestedCollection(
        data: identical(data, _nestedCollectionCopyWithPlaceholder)
            ? instance.data
            : data as List<Map<String, String>>,
      );
    }

    return copyWithFn as NestedCollectionCopyWithFn;
  }
}

typedef NullableFieldsCopyWithFn =
    NullableFields Function({String required, String? optional});

const Object _nullableFieldsCopyWithPlaceholder = Object();

extension NullableFieldsCopyWith on NullableFields {
  NullableFieldsCopyWithFn get copyWith {
    final instance = this;
    NullableFields copyWithFn({
      Object required = _nullableFieldsCopyWithPlaceholder,
      Object? optional = _nullableFieldsCopyWithPlaceholder,
    }) {
      return NullableFields(
        required: identical(required, _nullableFieldsCopyWithPlaceholder)
            ? instance.required
            : required as String,
        optional: identical(optional, _nullableFieldsCopyWithPlaceholder)
            ? instance.optional
            : optional as String?,
      );
    }

    return copyWithFn as NullableFieldsCopyWithFn;
  }
}

typedef LargeObjectCopyWithFn =
    LargeObject Function({String data1, int data2, bool data3});

const Object _largeObjectCopyWithPlaceholder = Object();

extension LargeObjectCopyWith on LargeObject {
  LargeObjectCopyWithFn get copyWith {
    final instance = this;
    LargeObject copyWithFn({
      Object data1 = _largeObjectCopyWithPlaceholder,
      Object data2 = _largeObjectCopyWithPlaceholder,
      Object data3 = _largeObjectCopyWithPlaceholder,
    }) {
      return LargeObject(
        data1: identical(data1, _largeObjectCopyWithPlaceholder)
            ? instance.data1
            : data1 as String,
        data2: identical(data2, _largeObjectCopyWithPlaceholder)
            ? instance.data2
            : data2 as int,
        data3: identical(data3, _largeObjectCopyWithPlaceholder)
            ? instance.data3
            : data3 as bool,
      );
    }

    return copyWithFn as LargeObjectCopyWithFn;
  }
}

typedef ManyFieldsCopyWithFn =
    ManyFields Function({
      String field1,
      String field2,
      String field3,
      String field4,
      String field5,
      int field6,
      int field7,
      int field8,
      int field9,
      int field10,
    });

const Object _manyFieldsCopyWithPlaceholder = Object();

extension ManyFieldsCopyWith on ManyFields {
  ManyFieldsCopyWithFn get copyWith {
    final instance = this;
    ManyFields copyWithFn({
      Object field1 = _manyFieldsCopyWithPlaceholder,
      Object field2 = _manyFieldsCopyWithPlaceholder,
      Object field3 = _manyFieldsCopyWithPlaceholder,
      Object field4 = _manyFieldsCopyWithPlaceholder,
      Object field5 = _manyFieldsCopyWithPlaceholder,
      Object field6 = _manyFieldsCopyWithPlaceholder,
      Object field7 = _manyFieldsCopyWithPlaceholder,
      Object field8 = _manyFieldsCopyWithPlaceholder,
      Object field9 = _manyFieldsCopyWithPlaceholder,
      Object field10 = _manyFieldsCopyWithPlaceholder,
    }) {
      return ManyFields(
        field1: identical(field1, _manyFieldsCopyWithPlaceholder)
            ? instance.field1
            : field1 as String,
        field2: identical(field2, _manyFieldsCopyWithPlaceholder)
            ? instance.field2
            : field2 as String,
        field3: identical(field3, _manyFieldsCopyWithPlaceholder)
            ? instance.field3
            : field3 as String,
        field4: identical(field4, _manyFieldsCopyWithPlaceholder)
            ? instance.field4
            : field4 as String,
        field5: identical(field5, _manyFieldsCopyWithPlaceholder)
            ? instance.field5
            : field5 as String,
        field6: identical(field6, _manyFieldsCopyWithPlaceholder)
            ? instance.field6
            : field6 as int,
        field7: identical(field7, _manyFieldsCopyWithPlaceholder)
            ? instance.field7
            : field7 as int,
        field8: identical(field8, _manyFieldsCopyWithPlaceholder)
            ? instance.field8
            : field8 as int,
        field9: identical(field9, _manyFieldsCopyWithPlaceholder)
            ? instance.field9
            : field9 as int,
        field10: identical(field10, _manyFieldsCopyWithPlaceholder)
            ? instance.field10
            : field10 as int,
      );
    }

    return copyWithFn as ManyFieldsCopyWithFn;
  }
}
