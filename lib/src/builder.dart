import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'copy_with_generator.dart';

Builder copyWithBuilder(BuilderOptions options) {
  return PartBuilder([CopyWithGenerator()], '.g.dart');
}