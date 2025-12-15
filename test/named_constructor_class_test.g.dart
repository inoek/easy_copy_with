// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'named_constructor_class_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef NamedConstructorClassCopyWithFn =
    NamedConstructorClass Function({String name, int value});

const Object _namedConstructorClassCopyWithPlaceholder = Object();

extension NamedConstructorClassCopyWith on NamedConstructorClass {
  NamedConstructorClassCopyWithFn get copyWith {
    final instance = this;
    NamedConstructorClass copyWithFn({
      Object name = _namedConstructorClassCopyWithPlaceholder,
      Object value = _namedConstructorClassCopyWithPlaceholder,
    }) {
      return NamedConstructorClass.named(
        name: identical(name, _namedConstructorClassCopyWithPlaceholder)
            ? instance.name
            : name as String,
        value: identical(value, _namedConstructorClassCopyWithPlaceholder)
            ? instance.value
            : value as int,
      );
    }

    return copyWithFn as NamedConstructorClassCopyWithFn;
  }
}
