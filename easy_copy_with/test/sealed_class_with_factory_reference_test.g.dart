// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_class_with_factory_reference_test.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

typedef MixedSealedCopyWithFn = MixedSealed Function({int id, String tag});

extension MixedSealedCopyWith on MixedSealed {
  MixedSealedCopyWithFn get copyWith {
    return switch (this) {
      final MixedImpl x0 => x0.copyWith,
    };
  }
}

typedef MixedImplCopyWithFn = MixedImpl Function({int id, String tag});

const Object _mixedImplCopyWithPlaceholder = Object();

extension MixedImplCopyWith on MixedImpl {
  MixedImplCopyWithFn get copyWith {
    final instance = this;
    MixedImpl copyWithFn({
      Object id = _mixedImplCopyWithPlaceholder,
      Object tag = _mixedImplCopyWithPlaceholder,
    }) {
      return MixedImpl(
        id: identical(id, _mixedImplCopyWithPlaceholder)
            ? instance.id
            : id as int,
        tag: identical(tag, _mixedImplCopyWithPlaceholder)
            ? instance.tag
            : tag as String,
      );
    }

    return copyWithFn as MixedImplCopyWithFn;
  }
}

typedef SelfRedirectSealedCopyWithFn =
    SelfRedirectSealed Function({String data});

extension SelfRedirectSealedCopyWith on SelfRedirectSealed {
  SelfRedirectSealedCopyWithFn get copyWith {
    return switch (this) {
      final SelfRedirectImpl x0 => x0.copyWith,
    };
  }
}

typedef SelfRedirectImplCopyWithFn = SelfRedirectImpl Function({String data});

const Object _selfRedirectImplCopyWithPlaceholder = Object();

extension SelfRedirectImplCopyWith on SelfRedirectImpl {
  SelfRedirectImplCopyWithFn get copyWith {
    final instance = this;
    SelfRedirectImpl copyWithFn({
      Object data = _selfRedirectImplCopyWithPlaceholder,
    }) {
      return SelfRedirectImpl(
        data: identical(data, _selfRedirectImplCopyWithPlaceholder)
            ? instance.data
            : data as String,
      );
    }

    return copyWithFn as SelfRedirectImplCopyWithFn;
  }
}

typedef NoFactoriesSealedCopyWithFn = NoFactoriesSealed Function({String val});

extension NoFactoriesSealedCopyWith on NoFactoriesSealed {
  NoFactoriesSealedCopyWithFn get copyWith {
    return switch (this) {
      final NoFactoriesImpl x0 => x0.copyWith,
    };
  }
}

typedef NoFactoriesImplCopyWithFn = NoFactoriesImpl Function({String val});

const Object _noFactoriesImplCopyWithPlaceholder = Object();

extension NoFactoriesImplCopyWith on NoFactoriesImpl {
  NoFactoriesImplCopyWithFn get copyWith {
    final instance = this;
    NoFactoriesImpl copyWithFn({
      Object val = _noFactoriesImplCopyWithPlaceholder,
    }) {
      return NoFactoriesImpl(
        identical(val, _noFactoriesImplCopyWithPlaceholder)
            ? instance.val
            : val as String,
      );
    }

    return copyWithFn as NoFactoriesImplCopyWithFn;
  }
}
