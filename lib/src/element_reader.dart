/// Bridges `package:analyzer` and the pure-Dart model consumed by the
/// code emitter.
///
/// **This is the only file in the package that depends on the analyzer
/// element model.** All logic that navigates `ClassElement`, reads type
/// information, or inspects constructor parameters lives here. Everything
/// downstream works on [ClassCopyWithInfo] objects, which are plain Dart.
///
/// When `package:analyzer` ships a breaking change, the fix is contained
/// to this file — the generator and the emitter stay untouched.
///
/// `isSynthetic` is marked `@Deprecated` in analyzer >= 9 in favour of
/// the `isOriginX` family, but those replacements don't exist in analyzer
/// 8.x. Until we drop 8.x support we intentionally keep the deprecated
/// member to stay compatible across analyzer 8.x / 9.x / 10.x.
library;

// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:source_gen/source_gen.dart';

import 'model.dart';

/// Reads an [Element] delivered by `source_gen` and returns the pure
/// [ClassCopyWithInfo] description of what needs to be generated.
///
/// Throws [InvalidGenerationSourceError] if the element is not a suitable
/// class (e.g. non-class element, abstract non-sealed class, class with
/// no suitable constructor, missing name).
ClassCopyWithInfo readClassCopyWith(Element element) {
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

  final typeParameters = _readTypeParameters(element.typeParameters);

  if (element.isSealed) {
    return _readSealed(element, className, typeParameters);
  }

  return _readConcrete(element, className, typeParameters);
}

ConcreteClassInfo _readConcrete(
  ClassElement element,
  String className,
  List<TypeParamInfo> typeParameters,
) {
  final constructor = _findSuitableConstructor(element);
  if (constructor == null) {
    throw InvalidGenerationSourceError(
      'No suitable constructor found for $className.',
      element: element,
    );
  }

  return ConcreteClassInfo(
    name: className,
    typeParameters: typeParameters,
    constructorDisplayName: constructor.displayName,
    params: _readParams(constructor),
  );
}

SealedClassInfo _readSealed(
  ClassElement element,
  String className,
  List<TypeParamInfo> typeParameters,
) {
  final subclassElements = _getExhaustiveClassesFrom(element)
      .where((e) => e != element)
      .toList(growable: false);

  final subclasses = <ConcreteClassInfo>[];
  for (final sub in subclassElements) {
    final subName = sub.name;
    if (subName == null) continue;
    final constructor = _findSuitableConstructor(sub);
    if (constructor == null) continue;
    subclasses.add(
      ConcreteClassInfo(
        name: subName,
        typeParameters: _readTypeParameters(sub.typeParameters),
        constructorDisplayName: constructor.displayName,
        params: _readParams(constructor),
      ),
    );
  }

  return SealedClassInfo(
    name: className,
    typeParameters: typeParameters,
    subclasses: subclasses,
    sharedFieldDeclarations: _computeSharedFieldDeclarations(
      sealed: element,
      subclasses: subclassElements,
    ),
  );
}

List<TypeParamInfo> _readTypeParameters(List<TypeParameterElement> tps) {
  return tps.map((tp) {
    final bound = tp.bound;
    String? boundStr;
    if (bound != null) {
      final display = bound.getDisplayString();
      if (display != 'dynamic') boundStr = display;
    }
    return TypeParamInfo(name: tp.name ?? '', bound: boundStr);
  }).toList(growable: false);
}

ConstructorElement? _findSuitableConstructor(ClassElement classElement) {
  final unnamed = classElement.unnamedConstructor;
  if (unnamed != null && !unnamed.isPrivate && !unnamed.isFactory) {
    return unnamed;
  }
  final constructors = classElement.constructors.where(
    (c) => !c.isPrivate && !c.isFactory,
  );
  return constructors.isEmpty ? null : constructors.first;
}

List<ParamInfo> _readParams(ConstructorElement constructor) {
  return constructor.formalParameters
      .where((p) => !p.isStatic && !p.isSynthetic)
      .map(
        (p) => p is SuperFormalParameterElement ? _unwrapSuper(p) : p,
      )
      .map(
        (p) => ParamInfo(
          name: p.name ?? '',
          typeDisplay: p.type.getDisplayString(),
          isNullable: p.type.nullabilitySuffix == NullabilitySuffix.question,
          isNamed: p.isNamed,
        ),
      )
      .toList(growable: false);
}

FormalParameterElement _unwrapSuper(FormalParameterElement element) {
  return switch (element) {
    SuperFormalParameterElement(:final superConstructorParameter?) =>
      _unwrapSuper(superConstructorParameter),
    final FieldFormalParameterElement fieldFormal => fieldFormal,
    _ => element,
  };
}

List<ClassElement> _getExhaustiveClassesFrom(ClassElement element) {
  return element.library.classes
      .where((e) => e.allSupertypes.any((t) => t.element == element))
      .toList(growable: false);
}

/// Computes the shared-field declarations for a sealed class: the set of
/// `"Type name"` strings that appears on every subclass. Preserves the
/// exact counting semantics of the pre-refactor generator so that the
/// emitted code is byte-for-byte identical.
List<String> _computeSharedFieldDeclarations({
  required ClassElement sealed,
  required List<ClassElement> subclasses,
}) {
  final fieldsFromSealed = sealed.fields
      .where((e) => !e.isSynthetic && !e.isStatic)
      .map((e) => e.displayString())
      .toSet();

  final fieldsFromSubs = subclasses
      .expand((e) => e.fields)
      .where((e) => !e.isSynthetic && !e.isStatic)
      .map((e) => e.displayString())
      .toSet();

  final candidates = <String, int>{
    for (final name in {...fieldsFromSealed, ...fieldsFromSubs}) name: 0,
  };

  for (final sub in subclasses) {
    for (final field in sub.fields) {
      final key = field.displayString();
      if (candidates.containsKey(key)) {
        candidates[key] = candidates[key]! + 1;
      }
    }
  }

  final total = subclasses.length;
  return candidates.entries
      .where((e) => e.value == total)
      .map((e) => e.key)
      .toList(growable: false);
}
