import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:easy_copy_with_annotation/easy_copy_with_annotation.dart';
import 'copy_with_emitter.dart';
import 'element_reader.dart';

/// `source_gen` entry point for the `@CopyWith()` annotation.
///
/// This class is deliberately minimal: it only implements the hook
/// required by `source_gen` and then hands off to the two pure pieces:
///
/// * [readClassCopyWith] — the single place that depends on
///   `package:analyzer` and transforms the analyzer element model into
///   the pure-Dart [ClassCopyWithInfo] data model.
/// * [emitCopyWith] — emits the generated source string from the model,
///   with no analyzer dependency of its own.
///
/// The only reason this file still imports `package:analyzer` is the
/// method signature [GeneratorForAnnotation.generateForAnnotatedElement]
/// requires an [Element] parameter. Zero methods are called on that
/// element here; it's passed straight to the reader.
class CopyWithGenerator extends GeneratorForAnnotation<CopyWith> {
  const CopyWithGenerator();

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final info = readClassCopyWith(element);
    return emitCopyWith(info);
  }
}
