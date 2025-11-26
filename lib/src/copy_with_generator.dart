import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import '../annotations.dart';

class CopyWithGenerator extends GeneratorForAnnotation<CopyWith> {
  const CopyWithGenerator();

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

    if (element.isAbstract && !element.isSealed) {
      throw InvalidGenerationSourceError(
        'Cannot generate copyWith for abstract class $className.',
        element: element,
      );
    }

    if (element.isSealed) {
      return _generateForSealedClass(element: element);
    }

    final constructor = _findSuitableConstructor(element);
    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'No suitable constructor found for $className.',
        element: element,
      );
    }

    return _generateExtensionForClass(element);
  }

  String _generateExtensionForClass(ClassElement element) {
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

    final placeholderName = '_${_toLowerCamel(className)}CopyWithPlaceholder';
    final buffer = StringBuffer()
      ..writeln(_generateTypedef(className, typeParameters, fields))
      ..writeln('const Object $placeholderName = Object();')
      ..writeln(
        _generateCopyWithExtension(
          className: className,
          classNameWithGenerics: classNameWithGenerics,
          typeParameters: typeParameters,
          fields: fields,
          placeholderName: placeholderName,
        ),
      );

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
    final targetClassFields = classElement.fields
        .where((field) => !field.isStatic && !field.isSynthetic)
        .toList();
    if (classElement.supertype?.element case final ClassElement superElement
        when superElement.isSealed) {
      final sealedFields = classElement.supertype?.element.fields
          .where((field) => !field.isStatic && !field.isSynthetic)
          .toList();

      return [...?sealedFields, ...targetClassFields];
    }
    return targetClassFields;
  }

  String _generateTypedef(
    String className,
    List<TypeParameterElement> typeParameters,
    List<FieldElement> fields,
  ) {
    final typeParamsDeclaration = _typeParametersDeclaration(typeParameters);
    final typeArgs = _typeArguments(typeParameters);
    final typedefName = '${className}CopyWithFn';

    final buffer = StringBuffer()
      ..writeln(
        'typedef $typedefName$typeParamsDeclaration = $className$typeArgs Function({',
      );

    for (final field in fields) {
      final paramType = _parameterTypeFor(field);
      buffer.writeln('  $paramType ${field.name},');
    }

    buffer.writeln('});');
    return buffer.toString();
  }

  String _generateCopyWithExtension({
    required String className,
    required String classNameWithGenerics,
    required List<TypeParameterElement> typeParameters,
    required List<FieldElement> fields,
    required String placeholderName,
  }) {
    final typeParamsDeclaration = _typeParametersDeclaration(typeParameters);
    final typeArgs = _typeArguments(typeParameters);
    final typedefName = '${className}CopyWithFn';

    final buffer = StringBuffer()
      ..writeln(
        'extension ${className}CopyWith$typeParamsDeclaration on $classNameWithGenerics {',
      )
      ..writeln('  $typedefName$typeParamsDeclaration get copyWith {')
      ..writeln('    final instance = this;')
      ..writeln('    $classNameWithGenerics copyWithFn({');

    for (final field in fields) {
      final isNullsable =
          field.type.nullabilitySuffix == NullabilitySuffix.question;
      buffer.writeln(
        '      Object${isNullsable ? '?' : ''} ${field.name} = $placeholderName,',
      );
    }

    buffer
      ..writeln('    }) {')
      ..writeln('      return $classNameWithGenerics(');

    for (final field in fields) {
      buffer.writeln(
        '        ${field.name}: ${_fieldAssignment(field, placeholderName)},',
      );
    }

    buffer
      ..writeln('      );')
      ..writeln('    }')
      ..writeln('    return copyWithFn as $typedefName$typeArgs;')
      ..writeln('  }')
      ..writeln('}');

    return buffer.toString();
  }

  String _typeParametersDeclaration(List<TypeParameterElement> typeParameters) {
    if (typeParameters.isEmpty) {
      return '';
    }

    final declaration = typeParameters
        .map((param) {
          final bound = param.bound;
          if (bound == null) {
            return param.name;
          }

          final boundType = bound.getDisplayString();
          if (boundType == 'dynamic') {
            return param.name;
          }

          return '${param.name} extends $boundType';
        })
        .join(', ');
    return '<$declaration>';
  }

  String _typeArguments(List<TypeParameterElement> typeParameters) {
    if (typeParameters.isEmpty) {
      return '';
    }

    final args = typeParameters.map((param) => param.name).join(', ');
    return '<$args>';
  }

  String _parameterTypeFor(FieldElement field) {
    final fieldType = field.type.getDisplayString();

    return fieldType;
  }

  String _fieldAssignment(FieldElement field, String placeholderName) {
    final fieldName = field.name;
    final fieldAccess = 'instance.$fieldName';
    final fieldType = field.type.getDisplayString();

    return 'identical($fieldName, $placeholderName) ? $fieldAccess : $fieldName as $fieldType';
  }

  String _toLowerCamel(String value) {
    if (value.isEmpty) {
      return value;
    }

    if (value.length == 1) {
      return value.toLowerCase();
    }

    return value[0].toLowerCase() + value.substring(1);
  }

  String _generateForSealedClass({required ClassElement element}) {
    final factoryRedirectedConstructorClasses = element.constructors
        .where((c) => c.isFactory)
        .map((e) => e.redirectedConstructor?.enclosingElement as ClassElement)
        .whereType<ClassElement>()
        .toList();

    return factoryRedirectedConstructorClasses
        .map(_generateExtensionForClass)
        .join('\n');
  }
}
