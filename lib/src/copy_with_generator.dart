import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
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

    if (element.isAbstract) {
      throw InvalidGenerationSourceError(
        'Cannot generate copyWith for abstract class $className.',
        element: element,
      );
    }

    final constructor = _findSuitableConstructor(element);
    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'No suitable constructor found for $className.',
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

    final buffer = StringBuffer();

    buffer.writeln('extension ${className}CopyWith$typeParamsString on $classNameWithGenerics {');
    buffer.writeln(_generateCopyWithMethod(classNameWithGenerics, fields, className));
    buffer.writeln('}');

    return buffer.toString();
  }


  ConstructorElement? _findSuitableConstructor(ClassElement classElement) {
    final unnamed = classElement.unnamedConstructor;
    if (unnamed != null && !unnamed.isPrivate && !unnamed.isFactory) {
      return unnamed;
    }

    try {
      return classElement.constructors.firstWhere(
            (c) => !c.isPrivate && !c.isFactory,
      );
    } catch (e) {
      return null;
    }
  }

  List<FieldElement> _getFields(ClassElement classElement) {
    return classElement.fields
        .where((field) => !field.isStatic && !field.isSynthetic)
        .toList();
  }

  String _generateCopyWithMethod(
      String className,
      List<FieldElement> fields,
      String classBaseName,
      ) {
    final buffer = StringBuffer()
      ..writeln('  $className copyWith({');

    for (final field in fields) {
      final fieldType = field.type.getDisplayString();
      final isNullable = field.type.nullabilitySuffix == NullabilitySuffix.question;

      if (isNullable) {
        buffer.writeln('    Object? ${field.name} = const Object(),');
      } else {
        buffer.writeln('    $fieldType? ${field.name},');
      }
    }

    buffer
      ..writeln('  }) {')
      ..writeln('    return $className(');

    for (final field in fields) {
      final fieldName = field.name;
      final isNullable = field.type.nullabilitySuffix == NullabilitySuffix.question;

      buffer.write('      $fieldName: ');

      if (isNullable) {
        buffer.writeln('$fieldName == const Object() ? this.$fieldName : $fieldName as ${_getBaseTypeString(field.type)}?,');
      } else {
        buffer.writeln('$fieldName ?? this.$fieldName,');
      }
    }

    buffer
      ..writeln('    );')
      ..writeln('  }');

    return buffer.toString();
  }

  String _getBaseTypeString(DartType type) {
    final typeStr = type.getDisplayString();

    if (type.nullabilitySuffix == NullabilitySuffix.question &&
        typeStr.endsWith('?')) {
      return typeStr.substring(0, typeStr.length - 1);
    }

    return typeStr;
  }
}