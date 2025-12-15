# Changelog

## [3.3.0] - 2025-12-15
- Added supporting exhaustive checking for sealed classes. Before was based on factory constructors.
- Fixed bug for generating classes with inherited fields.
- Added supporting named constructors.

## [3.2.2] - 2025-12-12
- Fixed behavior where inherited fields were passed to typedef

## [3.2.1] - 2025-12-12
- Fixes a crash in the generator when a sealed class contains a non-redirecting factory constructor

## [3.2.0] - 2025-12-11
- Added generation general fields for sealed classes.

## [3.1.0] - 2025-11-26
- Added codegen for sealed classes.

## [3.0.0]
- default output now targets `.g.dart` via a shared part builder, avoiding clashes with other `source_gen`-based packages like `json_serializable`
- documented how to override the extension when a dedicated `.copy_with.dart` file is preferred
- restructured the bundled example into a proper library with clear english instructions for running `build_runner`

## [2.0.0]
- copyWith parameters now preserve the original field types, including generics and nullability
- sentinel-backed parameters allow assigning `null` without manual casts
- packaged runnable example at `example/example.dart` and updated documentation to match
- switched licensing references to MIT and ensured generated example outputs ship with the package

## [1.0.0]
- initial release
