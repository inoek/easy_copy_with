/// Pure-Dart data model describing a class annotated with `@CopyWith()`.
///
/// This model is the contract between [element_reader.dart] (the only file
/// that touches `package:analyzer`) and [copy_with_emitter.dart] (which
/// produces the generated source string).
///
/// Keeping the model pure insulates the code-emission logic from breaking
/// changes in the analyzer element model between versions: when analyzer
/// ships a major version with API changes, only the reader needs updating.
library;

/// Marker base type for every class the generator may emit code for.
sealed class ClassCopyWithInfo {
  const ClassCopyWithInfo({
    required this.name,
    required this.typeParameters,
  });

  /// Simple class name (no generics), e.g. `User`.
  final String name;

  /// Declared type parameters of the class, in source order.
  final List<TypeParamInfo> typeParameters;
}

/// A regular, non-sealed class with a concrete constructor whose parameters
/// become the fields of the generated `copyWith`.
class ConcreteClassInfo extends ClassCopyWithInfo {
  const ConcreteClassInfo({
    required super.name,
    required super.typeParameters,
    required this.constructorDisplayName,
    required this.params,
  });

  /// Full constructor invocation name, e.g. `User` or `User.named`. Used
  /// verbatim at the call site inside the generated `copyWith`.
  final String constructorDisplayName;

  /// Parameters of the selected constructor, in declaration order.
  final List<ParamInfo> params;
}

/// A sealed class with a known set of exhaustive concrete subclasses in
/// the same library.
class SealedClassInfo extends ClassCopyWithInfo {
  const SealedClassInfo({
    required super.name,
    required super.typeParameters,
    required this.subclasses,
    required this.sharedFieldDeclarations,
  });

  /// Subclasses that extend this sealed class in the current library. The
  /// generator emits a regular copyWith extension for each of them.
  final List<ConcreteClassInfo> subclasses;

  /// Field declarations shared by every subclass, pre-formatted as
  /// `"Type name"` strings (e.g. `"int baseValue"`). When non-empty, the
  /// generator emits a dispatch extension on the sealed class itself that
  /// forwards to the subclass-specific copyWith.
  final List<String> sharedFieldDeclarations;
}

/// Type parameter of a class, e.g. `T` or `T extends num`.
class TypeParamInfo {
  const TypeParamInfo({required this.name, this.bound});

  /// Identifier of the type parameter, e.g. `T`.
  final String name;

  /// Display form of the bound, or `null` when there is no bound (or when
  /// the bound is `dynamic`, which the generator treats as "no bound").
  final String? bound;
}

/// One parameter of the selected constructor.
class ParamInfo {
  const ParamInfo({
    required this.name,
    required this.typeDisplay,
    required this.isNullable,
    required this.isNamed,
  });

  /// Identifier of the parameter, e.g. `email`.
  final String name;

  /// Display form of the parameter's type, e.g. `String?` or `List<int>`.
  final String typeDisplay;

  /// Whether the parameter type allows `null`.
  final bool isNullable;

  /// `true` for named parameters, `false` for positional ones.
  final bool isNamed;
}
