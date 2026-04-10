/// Emits the generated `copyWith` source code for a class described by
/// [ClassCopyWithInfo]. Pure Dart — **no `package:analyzer` imports**.
///
/// Keeping the emitter analyzer-free means its behaviour is stable across
/// analyzer versions and can be exercised from unit tests by constructing
/// [ClassCopyWithInfo] instances directly.
library;

import 'model.dart';

/// Entry point — produces the full generated source for one annotated class.
String emitCopyWith(ClassCopyWithInfo info) {
  return switch (info) {
    ConcreteClassInfo() => _emitConcrete(info),
    SealedClassInfo() => _emitSealed(info),
  };
}

String _emitConcrete(ConcreteClassInfo info) {
  if (info.params.isEmpty) return '';

  final placeholderName = _placeholderFor(info.name);
  final buffer = StringBuffer()
    ..writeln(
      _typedef(
        info.name,
        info.typeParameters,
        info.params.map((p) => '${p.typeDisplay} ${p.name}').toList(),
      ),
    )
    ..writeln('const Object $placeholderName = Object();')
    ..writeln(_extension(info, placeholderName));

  return buffer.toString();
}

String _emitSealed(SealedClassInfo info) {
  final sharedExtension = info.sharedFieldDeclarations.isEmpty
      ? null
      : _emitSharedFieldsDispatch(info);

  final subclassExtensions = info.subclasses
      .map(_emitConcrete)
      .toList(growable: false);

  return [?sharedExtension, ...subclassExtensions].join('\n');
}

String _emitSharedFieldsDispatch(SealedClassInfo info) {
  final buffer = StringBuffer()
    ..writeln(
      _typedef(info.name, info.typeParameters, info.sharedFieldDeclarations),
    )
    ..writeln(_sealedSwitchExtension(info));
  return buffer.toString();
}

String _typedef(
  String className,
  List<TypeParamInfo> typeParameters,
  List<String> fields,
) {
  final decl = _typeParamsDecl(typeParameters);
  final args = _typeArgs(typeParameters);
  final typedefName = '${className}CopyWithFn';

  final buffer = StringBuffer()
    ..writeln(
      'typedef $typedefName$decl = $className$args Function({',
    );
  for (final field in fields) {
    buffer.writeln('  $field,');
  }
  buffer.writeln('});');
  return buffer.toString();
}

String _extension(ConcreteClassInfo info, String placeholderName) {
  final decl = _typeParamsDecl(info.typeParameters);
  final args = _typeArgs(info.typeParameters);
  final typedefName = '${info.name}CopyWithFn';
  final classNameWithGenerics = '${info.name}$args';

  final buffer = StringBuffer()
    ..writeln(
      'extension ${info.name}CopyWith$decl on $classNameWithGenerics {',
    )
    ..writeln('  $typedefName$decl get copyWith {')
    ..writeln('    final instance = this;')
    ..writeln('    $classNameWithGenerics copyWithFn({');

  for (final param in info.params) {
    final q = param.isNullable ? '?' : '';
    buffer.writeln('      Object$q ${param.name} = $placeholderName,');
  }

  buffer
    ..writeln('    }) {')
    ..writeln('      return ${info.constructorDisplayName}(');

  for (final param in info.params) {
    final assignment = _paramAssignment(param, placeholderName);
    if (param.isNamed) {
      buffer.writeln('        ${param.name}: $assignment,');
    } else {
      buffer.writeln('        $assignment,');
    }
  }

  buffer
    ..writeln('      );')
    ..writeln('    }')
    ..writeln('    return copyWithFn as $typedefName$args;')
    ..writeln('  }')
    ..writeln('}');

  return buffer.toString();
}

String _sealedSwitchExtension(SealedClassInfo info) {
  final decl = _typeParamsDecl(info.typeParameters);
  final args = _typeArgs(info.typeParameters);
  final typedefName = '${info.name}CopyWithFn';
  final classNameWithGenerics = '${info.name}$args';

  final buffer = StringBuffer()
    ..writeln(
      'extension ${info.name}CopyWith$decl on $classNameWithGenerics {',
    )
    ..writeln('  $typedefName$decl get copyWith {')
    ..writeln('    return switch (this) {');

  for (final (i, sub) in info.subclasses.indexed) {
    buffer.writeln('      final ${sub.name} x$i => x$i.copyWith,');
  }

  buffer
    ..writeln('    };')
    ..writeln('  }')
    ..writeln('}');

  return buffer.toString();
}

String _paramAssignment(ParamInfo param, String placeholderName) {
  final fieldAccess = 'instance.${param.name}';
  return 'identical(${param.name}, $placeholderName) '
      '? $fieldAccess '
      ': ${param.name} as ${param.typeDisplay}';
}

String _typeParamsDecl(List<TypeParamInfo> typeParameters) {
  if (typeParameters.isEmpty) return '';
  final decl = typeParameters
      .map((p) => p.bound == null ? p.name : '${p.name} extends ${p.bound}')
      .join(', ');
  return '<$decl>';
}

String _typeArgs(List<TypeParamInfo> typeParameters) {
  if (typeParameters.isEmpty) return '';
  return '<${typeParameters.map((p) => p.name).join(', ')}>';
}

String _placeholderFor(String className) {
  return '_${_toLowerCamel(className)}CopyWithPlaceholder';
}

String _toLowerCamel(String value) {
  if (value.isEmpty) return value;
  if (value.length == 1) return value.toLowerCase();
  return value[0].toLowerCase() + value.substring(1);
}
