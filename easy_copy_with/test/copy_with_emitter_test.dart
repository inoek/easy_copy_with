import 'package:easy_copy_with/src/copy_with_emitter.dart';
import 'package:easy_copy_with/src/model.dart';
import 'package:test/test.dart';

void main() {
  group('emitCopyWith', () {
    group('ConcreteClassInfo', () {
      test('emits nothing for a class with no params', () {
        const info = ConcreteClassInfo(
          name: 'Empty',
          typeParameters: [],
          constructorDisplayName: 'Empty',
          params: [],
        );

        expect(emitCopyWith(info), isEmpty);
      });

      test('emits typedef, placeholder, and extension for a simple class', () {
        const info = ConcreteClassInfo(
          name: 'Person',
          typeParameters: [],
          constructorDisplayName: 'Person',
          params: [
            ParamInfo(
              name: 'name',
              typeDisplay: 'String',
              isNullable: false,
              isNamed: true,
            ),
            ParamInfo(
              name: 'age',
              typeDisplay: 'int',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('typedef PersonCopyWithFn'));
        expect(output, contains('Person Function({'));
        expect(output, contains('String name,'));
        expect(output, contains('int age,'));
        expect(output, contains('const Object _personCopyWithPlaceholder'));
        expect(output, contains('extension PersonCopyWith on Person'));
        expect(output, contains('PersonCopyWithFn get copyWith'));
        expect(output, contains('return Person('));
        expect(output, contains("identical(name, _personCopyWithPlaceholder)"));
        expect(output, contains('name as String'));
        expect(output, contains('age as int'));
      });

      test('handles nullable params with Object? parameter type', () {
        const info = ConcreteClassInfo(
          name: 'User',
          typeParameters: [],
          constructorDisplayName: 'User',
          params: [
            ParamInfo(
              name: 'email',
              typeDisplay: 'String?',
              isNullable: true,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('Object? email = _userCopyWithPlaceholder'));
        expect(output, contains('email as String?'));
      });

      test('handles non-nullable params with Object parameter type', () {
        const info = ConcreteClassInfo(
          name: 'Item',
          typeParameters: [],
          constructorDisplayName: 'Item',
          params: [
            ParamInfo(
              name: 'count',
              typeDisplay: 'int',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('Object count = _itemCopyWithPlaceholder'));
        expect(output, isNot(contains('Object? count')));
      });

      test('emits positional param without name: prefix', () {
        const info = ConcreteClassInfo(
          name: 'Pos',
          typeParameters: [],
          constructorDisplayName: 'Pos',
          params: [
            ParamInfo(
              name: 'x',
              typeDisplay: 'int',
              isNullable: false,
              isNamed: false,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, isNot(contains('x: identical')));
        expect(output, contains('identical(x, _posCopyWithPlaceholder)'));
      });

      test('uses named constructor display name', () {
        const info = ConcreteClassInfo(
          name: 'Foo',
          typeParameters: [],
          constructorDisplayName: 'Foo.named',
          params: [
            ParamInfo(
              name: 'v',
              typeDisplay: 'int',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('return Foo.named('));
      });

      test('emits type parameters in typedef and extension', () {
        const info = ConcreteClassInfo(
          name: 'Box',
          typeParameters: [
            TypeParamInfo(name: 'T'),
          ],
          constructorDisplayName: 'Box',
          params: [
            ParamInfo(
              name: 'value',
              typeDisplay: 'T',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('typedef BoxCopyWithFn<T>'));
        expect(output, contains('Box<T> Function({'));
        expect(output, contains('extension BoxCopyWith<T> on Box<T>'));
        expect(output, contains('BoxCopyWithFn<T> get copyWith'));
        expect(output, contains('return copyWithFn as BoxCopyWithFn<T>'));
      });

      test('emits bounded type parameters', () {
        const info = ConcreteClassInfo(
          name: 'NumBox',
          typeParameters: [
            TypeParamInfo(name: 'T', bound: 'num'),
          ],
          constructorDisplayName: 'NumBox',
          params: [
            ParamInfo(
              name: 'value',
              typeDisplay: 'T',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('typedef NumBoxCopyWithFn<T extends num>'));
        expect(output, contains('extension NumBoxCopyWith<T extends num>'));
      });

      test('emits multiple type parameters', () {
        const info = ConcreteClassInfo(
          name: 'Pair',
          typeParameters: [
            TypeParamInfo(name: 'A'),
            TypeParamInfo(name: 'B'),
          ],
          constructorDisplayName: 'Pair',
          params: [
            ParamInfo(
              name: 'first',
              typeDisplay: 'A',
              isNullable: false,
              isNamed: true,
            ),
            ParamInfo(
              name: 'second',
              typeDisplay: 'B',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('<A, B>'));
        expect(output, contains('Pair<A, B> Function({'));
      });
    });

    group('SealedClassInfo', () {
      test('emits only subclass extensions when no shared fields', () {
        const info = SealedClassInfo(
          name: 'Shape',
          typeParameters: [],
          subclasses: [
            ConcreteClassInfo(
              name: 'Circle',
              typeParameters: [],
              constructorDisplayName: 'Circle',
              params: [
                ParamInfo(
                  name: 'radius',
                  typeDisplay: 'double',
                  isNullable: false,
                  isNamed: true,
                ),
              ],
            ),
            ConcreteClassInfo(
              name: 'Rect',
              typeParameters: [],
              constructorDisplayName: 'Rect',
              params: [
                ParamInfo(
                  name: 'width',
                  typeDisplay: 'double',
                  isNullable: false,
                  isNamed: true,
                ),
              ],
            ),
          ],
          sharedFieldDeclarations: [],
        );

        final output = emitCopyWith(info);

        expect(output, contains('extension CircleCopyWith on Circle'));
        expect(output, contains('extension RectCopyWith on Rect'));
        expect(output, isNot(contains('extension ShapeCopyWith')));
      });

      test('emits dispatch extension when shared fields exist', () {
        const info = SealedClassInfo(
          name: 'Result',
          typeParameters: [],
          subclasses: [
            ConcreteClassInfo(
              name: 'Ok',
              typeParameters: [],
              constructorDisplayName: 'Ok',
              params: [
                ParamInfo(
                  name: 'code',
                  typeDisplay: 'int',
                  isNullable: false,
                  isNamed: true,
                ),
              ],
            ),
            ConcreteClassInfo(
              name: 'Err',
              typeParameters: [],
              constructorDisplayName: 'Err',
              params: [
                ParamInfo(
                  name: 'code',
                  typeDisplay: 'int',
                  isNullable: false,
                  isNamed: true,
                ),
              ],
            ),
          ],
          sharedFieldDeclarations: ['int code'],
        );

        final output = emitCopyWith(info);

        expect(output, contains('typedef ResultCopyWithFn'));
        expect(output, contains('extension ResultCopyWith on Result'));
        expect(output, contains('return switch (this)'));
        expect(output, contains('final Ok x0 => x0.copyWith'));
        expect(output, contains('final Err x1 => x1.copyWith'));
        expect(output, contains('extension OkCopyWith on Ok'));
        expect(output, contains('extension ErrCopyWith on Err'));
      });

      test('handles sealed class with empty subclass params', () {
        const info = SealedClassInfo(
          name: 'Token',
          typeParameters: [],
          subclasses: [
            ConcreteClassInfo(
              name: 'EmptyToken',
              typeParameters: [],
              constructorDisplayName: 'EmptyToken',
              params: [],
            ),
          ],
          sharedFieldDeclarations: [],
        );

        final output = emitCopyWith(info);

        expect(output, isEmpty);
      });
    });

    group('placeholder naming', () {
      test('lowercases first char for camelCase placeholder', () {
        const info = ConcreteClassInfo(
          name: 'MyClass',
          typeParameters: [],
          constructorDisplayName: 'MyClass',
          params: [
            ParamInfo(
              name: 'x',
              typeDisplay: 'int',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('_myClassCopyWithPlaceholder'));
      });

      test('handles single-char class name', () {
        const info = ConcreteClassInfo(
          name: 'X',
          typeParameters: [],
          constructorDisplayName: 'X',
          params: [
            ParamInfo(
              name: 'v',
              typeDisplay: 'int',
              isNullable: false,
              isNamed: true,
            ),
          ],
        );

        final output = emitCopyWith(info);

        expect(output, contains('_xCopyWithPlaceholder'));
      });
    });
  });
}
