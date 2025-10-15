import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'copy_with_generator.dart';

Builder copyWithBuilder(BuilderOptions options) {
  final extension = options.config['output_extension'] as String? ?? '.g.dart';

  if (extension == '.g.dart') {
    return SharedPartBuilder(
      [CopyWithGenerator()],
      'copy_with',
    );
  }

  // When developers opt into a custom extension we fall back to a dedicated
  // part file to mirror the previous behaviour.
  return PartBuilder([CopyWithGenerator()], extension);
}
