import 'package:test/test.dart';
import 'package:easy_copy_with/easy_copy_with.dart';

part 'sealed_class_with_factory_reference_test.g.dart';

void main() {
  group('Complex Sealed Factories Tests', () {
    test(
      'MixedSealed generates copyWith ONLY for valid redirecting factory subclasses',
      () {
        const item = MixedImpl(id: 1, tag: 'A');
        final copy = item.copyWith(id: 2);
        expect(copy.id, 2);
        expect(copy.tag, 'A');
      },
    );

    test(
      'MixedSealed base copyWith works for common fields found in valid redirects',
      () {
        const MixedSealed base = MixedImpl(id: 10, tag: 'Base');
        final copy = base.copyWith(id: 20);
        expect((copy as MixedImpl).id, 20);
      },
    );

    test('SelfRedirectingSealed works for the valid subclass', () {
      const impl = SelfRedirectImpl(data: 'data');
      final copy = impl.copyWith(data: 'new');
      expect(copy.data, 'new');
    });
  });

  test('NoFactoriesSealed compilation check', () {
    const obj = NoFactoriesImpl('test');

    expect(obj.val, 'test');
  });
}

@CopyWith()
sealed class MixedSealed {
  const factory MixedSealed.valid({required int id, required String tag}) =
      MixedImpl;

  factory MixedSealed.fromString(String str) {
    return MixedImpl(id: 0, tag: str);
  }

  const MixedSealed.base();
}

class MixedImpl extends MixedSealed {
  const MixedImpl({required this.id, required this.tag}) : super.base();
  final int id;
  final String tag;
}

@CopyWith()
sealed class SelfRedirectSealed {
  const factory SelfRedirectSealed.create({required String data}) =
      SelfRedirectImpl;

  const factory SelfRedirectSealed.alias({required String data}) =
      SelfRedirectSealed.create;
}

class SelfRedirectImpl implements SelfRedirectSealed {
  const SelfRedirectImpl({required this.data});

  final String data;
}

@CopyWith()
sealed class NoFactoriesSealed {}

class NoFactoriesImpl implements NoFactoriesSealed {
  const NoFactoriesImpl(this.val);

  final String val;
}
