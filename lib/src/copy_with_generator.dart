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

    final classNameWithGenerics = _getClassNameWithGenerics(element);

    final placeholderName = _makePlaceholderFor(className);
    final buffer = StringBuffer()
      ..writeln(
        _generateTypedef(
          className,
          typeParameters,
          fields.map((e) => '${e.type.toString()} ${e.displayName}').toList(),
        ),
      )
      ..writeln('const Object $placeholderName = Object();')
      ..writeln(
        _generateCopyWithExtension(
          className: className,
          classNameWithGenerics: classNameWithGenerics,
          typeParameters: typeParameters,
          fields: fields,
          placeholderName: placeholderName,
          contructor: _findSuitableConstructor(element)!,
        ),
      );

    return buffer.toString();
  }

  String _makePlaceholderFor(String className) {
    return '_${_toLowerCamel(className)}CopyWithPlaceholder';
  }

  String _getClassNameWithGenerics(ClassElement element) {
    final typeParameters = element.typeParameters;
    final typeParamsString = typeParameters.isNotEmpty
        ? '<${typeParameters.map((e) => e.name).join(', ')}>'
        : '';

    final classNameWithGenerics = '${element.name}$typeParamsString';

    return classNameWithGenerics;
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

  List<FormalParameterElement> _getFields(ClassElement classElement) {
    final suitableConstructor = _findSuitableConstructor(classElement)!;
    final parameters = suitableConstructor.formalParameters;
    final targetClassFields = parameters
        .where((field) => !field.isStatic && !field.isSynthetic)
        .map(
          (e) => e is SuperFormalParameterElement
              ? _getBaseElementFromSuper(e)
              : e,
        )
        .toList(growable: false);

    return targetClassFields;
  }

  FormalParameterElement _getBaseElementFromSuper(
    FormalParameterElement element,
  ) {
    return switch (element) {
      SuperFormalParameterElement(:final superConstructorParameter?) =>
        _getBaseElementFromSuper(superConstructorParameter),
      final FieldFormalParameterElement fieldFormalElement =>
        fieldFormalElement,
      _ => element,
    };
  }

  String _generateTypedef(
    String className,
    List<TypeParameterElement> typeParameters,
    List<String> fields,
  ) {
    final typeParamsDeclaration = _typeParametersDeclaration(typeParameters);
    final typeArgs = _typeArguments(typeParameters);
    final typedefName = '${className}CopyWithFn';

    final buffer = StringBuffer()
      ..writeln(
        'typedef $typedefName$typeParamsDeclaration = $className$typeArgs Function({',
      );

    for (final field in fields) {
      buffer.writeln('  $field,');
    }

    buffer.writeln('});');
    return buffer.toString();
  }

  String _generateCopyWithExtension({
    required String className,
    required String classNameWithGenerics,
    required List<TypeParameterElement> typeParameters,
    required List<FormalParameterElement> fields,
    required String placeholderName,
    required ConstructorElement contructor,
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
      ..writeln('      return ${contructor.displayName}(');

    for (final field in fields) {
      if (field.isNamed) {
        buffer.writeln(
          '        ${field.name}: ${_fieldAssignment(field, placeholderName)},',
        );
      } else if (field.isPositional) {
        buffer.writeln('        ${_fieldAssignment(field, placeholderName)},');
      }
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

  String _fieldAssignment(
    FormalParameterElement field,
    String placeholderName,
  ) {
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
    final allExhaustiveClasses = _getExhaustiveClassesFrom(
      element,
    ).where((e) => e != element).toList(growable: false);

    final generalVairablesExtension = _generateForGeneralVariablesInSealedClass(
      element: element,
      exhaustiveClasses: allExhaustiveClasses,
    );

    final exhaustiveClassesGen = allExhaustiveClasses
        .map(_generateExtensionForClass)
        .toList(growable: false);

    return [?generalVairablesExtension, ...exhaustiveClassesGen].join('\n');
  }

  List<ClassElement> _getExhaustiveClassesFrom(ClassElement element) {
    return element.library.classes
        .where((e) => e.allSupertypes.any((e) => e.element == element))
        .toList(growable: false);
  }

  String? _generateForGeneralVariablesInSealedClass({
    required ClassElement element,
    required List<ClassElement> exhaustiveClasses,
  }) {
    final totalSameVariablesCount = exhaustiveClasses.length;

    final fieldsFromCurrentSealedClass = element.fields
        .where((e) => !e.isSynthetic && !e.isStatic)
        .map((e) => e.displayString())
        .toSet();

    final fieldsFromFactoryConstructors = exhaustiveClasses
        .expand((e) => e.fields)
        .where((e) => !e.isSynthetic && !e.isStatic)
        .map((e) => e.displayString())
        .toSet();

    final uniqueFieldNames = {
      ...fieldsFromCurrentSealedClass,
      ...fieldsFromFactoryConstructors,
    };

    final candidateFields = {for (final name in uniqueFieldNames) name: 0};

    for (final factory in exhaustiveClasses) {
      for (final field in factory.fields) {
        if (candidateFields.containsKey(field.displayString())) {
          candidateFields[field.displayString()] =
              candidateFields[field.displayString()]! + 1;
        }
      }
    }

    final targetFields = candidateFields.entries
        .where((e) => e.value == totalSameVariablesCount)
        .map((e) => e.key)
        .toList(growable: false);

    if (targetFields.isEmpty) {
      return null;
    }

    final className = element.name!;
    final typeParameters = element.typeParameters;
    final classNameWithGenerics = _getClassNameWithGenerics(element);
    final buffer = StringBuffer()
      ..writeln(_generateTypedef(className, typeParameters, targetFields))
      ..writeln(
        _generateExtesionForSealedClass(
          className: className,
          classNameWithGenerics: classNameWithGenerics,
          typeParameters: typeParameters,
          factories: _getExhaustiveClassesFrom(element),
        ),
      );

    return buffer.toString();
  }

  String _generateExtesionForSealedClass({
    required String className,
    required String classNameWithGenerics,
    required List<TypeParameterElement> typeParameters,
    required List<ClassElement> factories,
  }) {
    final typeParamsDeclaration = _typeParametersDeclaration(typeParameters);
    final typedefName = '${className}CopyWithFn';
    final buffer = StringBuffer()
      ..writeln(
        'extension ${className}CopyWith$typeParamsDeclaration on $classNameWithGenerics {',
      )
      ..writeln('  $typedefName$typeParamsDeclaration get copyWith {')
      ..writeln('    return switch (this) {')
      ..write(_generateSwitchForFactoriesInSealedClass(factories))
      ..writeln('    };')
      ..writeln('  }')
      ..writeln('}');

    return buffer.toString();
  }

  String _generateSwitchForFactoriesInSealedClass(
    List<ClassElement> factories,
  ) {
    final buffer = StringBuffer();

    for (final (i, factory) in factories.indexed) {
      final tempVarName = 'x$i';
      buffer.writeln(
        '      final ${factory.name} $tempVarName => $tempVarName.copyWith,',
      );
    }

    return buffer.toString();
  }
}
