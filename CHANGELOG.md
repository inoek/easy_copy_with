# Changelog

## [3.0.0] - TBD
- default output now targets `.g.dart` via a shared part builder, avoiding clashes with other `source_gen`-based packages like `json_serializable`
- documented how to override the extension when a dedicated `.copy_with.dart` file is preferred
- restructured the bundled example into a proper library with clear english instructions for running `build_runner`

## [2.0.0] - TBD
- copyWith parameters now preserve the original field types, including generics and nullability
- sentinel-backed parameters allow assigning `null` without manual casts
- packaged runnable example at `example/example.dart` and updated documentation to match
- switched licensing references to MIT and ensured generated example outputs ship with the package

## [1.0.0]
- initial release
