import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import '../annotations.dart';

class CopyWithGenerator extends GeneratorForAnnotation<CopyWith> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'CopyWith annotation can only be applied to classes.',
        element: element,
      );
    }

    final className = element.name;
    if (className == null) {
      throw InvalidGenerationSourceError(
        'Class name cannot be null.',
        element: element,
      );
    }

    final fields = _getFields(element);

    if (fields.isEmpty) {
      return '';
    }

    final typeParameters = element.typeParameters;
    final typeParamsString = typeParameters.isNotEmpty
        ? '<${typeParameters.map((e) => e.name).join(', ')}>'
        : '';

    final classNameWithGenerics = '$className$typeParamsString';

    final buffer = StringBuffer()
      ..writeln('extension ${className}CopyWith$typeParamsString on $classNameWithGenerics {')
      ..writeln(_generateCopyWithMethod(classNameWithGenerics, fields))
      ..writeln('}');

    return buffer.toString();
  }

  List<FieldElement> _getFields(ClassElement classElement) {
    return classElement.fields
        .where((field) => !field.isStatic && !field.isSynthetic)
        .toList();
  }

  String _generateCopyWithMethod(String className, List<FieldElement> fields) {
    const sentinelValue = 'const Object()';

    final buffer = StringBuffer()
      ..writeln('  $className copyWith({');

    for (final field in fields) {
      var fieldType = field.type.getDisplayString();
      if (fieldType.endsWith('?')) {
        fieldType = fieldType.substring(0, fieldType.length - 1);
        buffer.writeln('    Object? ${field.name} = $sentinelValue,');
      } else {
        buffer.writeln('    $fieldType? ${field.name},');
      }
    }

    buffer
      ..writeln('  }) {')
      ..writeln('    return $className(');

    // Generate field assignments
    for (final field in fields) {
      final fieldType = field.type.getDisplayString();
      if (fieldType.endsWith('?')) {
        buffer.writeln('      ${field.name}: ${field.name} == $sentinelValue ? this.${field.name} : ${field.name} as $fieldType,');
      } else {
        buffer.writeln('      ${field.name}: ${field.name} ?? this.${field.name},');
      }
    }

    buffer
      ..writeln('    );')
      ..writeln('  }');

    return buffer.toString();
  }
}