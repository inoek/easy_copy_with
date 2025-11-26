// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotations_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef TestClassWithAnnotationCopyWithFn =
    TestClassWithAnnotation Function({String name, int value});

const Object _testClassWithAnnotationCopyWithPlaceholder = Object();

extension TestClassWithAnnotationCopyWith on TestClassWithAnnotation {
  TestClassWithAnnotationCopyWithFn get copyWith {
    final instance = this;
    TestClassWithAnnotation copyWithFn({
      Object name = _testClassWithAnnotationCopyWithPlaceholder,
      Object value = _testClassWithAnnotationCopyWithPlaceholder,
    }) {
      return TestClassWithAnnotation(
        name: identical(name, _testClassWithAnnotationCopyWithPlaceholder)
            ? instance.name
            : name as String,
        value: identical(value, _testClassWithAnnotationCopyWithPlaceholder)
            ? instance.value
            : value as int,
      );
    }

    return copyWithFn as TestClassWithAnnotationCopyWithFn;
  }
}
