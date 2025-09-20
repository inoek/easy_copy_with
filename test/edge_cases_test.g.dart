// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'edge_cases_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension SingleStringCopyWith on SingleString {
  SingleString copyWith({String? value}) {
    return SingleString(value: value ?? this.value);
  }
}

extension SingleNullableCopyWith on SingleNullable {
  SingleNullable copyWith({Object? value = const Object()}) {
    return SingleNullable(
      value: value == const Object() ? this.value : value as String?,
    );
  }
}

extension SingleBoolCopyWith on SingleBool {
  SingleBool copyWith({bool? flag}) {
    return SingleBool(flag: flag ?? this.flag);
  }
}

extension TimestampedEventCopyWith on TimestampedEvent {
  TimestampedEvent copyWith({DateTime? timestamp, String? message}) {
    return TimestampedEvent(
      timestamp: timestamp ?? this.timestamp,
      message: message ?? this.message,
    );
  }
}

extension TaskWithDurationCopyWith on TaskWithDuration {
  TaskWithDuration copyWith({Duration? duration, String? name}) {
    return TaskWithDuration(
      duration: duration ?? this.duration,
      name: name ?? this.name,
    );
  }
}

extension LinkDataCopyWith on LinkData {
  LinkData copyWith({Uri? url, String? title}) {
    return LinkData(url: url ?? this.url, title: title ?? this.title);
  }
}

extension TaskStatusCopyWith on TaskStatus {
  TaskStatus copyWith({Status? status, String? name}) {
    return TaskStatus(status: status ?? this.status, name: name ?? this.name);
  }
}

extension StringListCopyWith on StringList {
  StringList copyWith({List<String>? items}) {
    return StringList(items: items ?? this.items);
  }
}

extension StringIntMapCopyWith on StringIntMap {
  StringIntMap copyWith({Map<String, int>? data}) {
    return StringIntMap(data: data ?? this.data);
  }
}

extension IntSetCopyWith on IntSet {
  IntSet copyWith({Set<int>? numbers}) {
    return IntSet(numbers: numbers ?? this.numbers);
  }
}

extension NestedCollectionCopyWith on NestedCollection {
  NestedCollection copyWith({List<Map<String, String>>? data}) {
    return NestedCollection(data: data ?? this.data);
  }
}

extension NullableFieldsCopyWith on NullableFields {
  NullableFields copyWith({
    String? required,
    Object? optional = const Object(),
  }) {
    return NullableFields(
      required: required ?? this.required,
      optional: optional == const Object()
          ? this.optional
          : optional as String?,
    );
  }
}

extension LargeObjectCopyWith on LargeObject {
  LargeObject copyWith({String? data1, int? data2, bool? data3}) {
    return LargeObject(
      data1: data1 ?? this.data1,
      data2: data2 ?? this.data2,
      data3: data3 ?? this.data3,
    );
  }
}

extension ManyFieldsCopyWith on ManyFields {
  ManyFields copyWith({
    String? field1,
    String? field2,
    String? field3,
    String? field4,
    String? field5,
    int? field6,
    int? field7,
    int? field8,
    int? field9,
    int? field10,
  }) {
    return ManyFields(
      field1: field1 ?? this.field1,
      field2: field2 ?? this.field2,
      field3: field3 ?? this.field3,
      field4: field4 ?? this.field4,
      field5: field5 ?? this.field5,
      field6: field6 ?? this.field6,
      field7: field7 ?? this.field7,
      field8: field8 ?? this.field8,
      field9: field9 ?? this.field9,
      field10: field10 ?? this.field10,
    );
  }
}
