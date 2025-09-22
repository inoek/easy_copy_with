import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'copy_with_generator.dart';

Builder copyWithBuilder(BuilderOptions options) {
  final extension = options.config['output_extension'] as String? ?? '.copy_with.dart';
  return PartBuilder([CopyWithGenerator()], extension);
}