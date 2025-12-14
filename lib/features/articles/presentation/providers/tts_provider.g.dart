// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleTts)
const articleTtsProvider = ArticleTtsFamily._();

final class ArticleTtsProvider extends $NotifierProvider<ArticleTts, TtsState> {
  const ArticleTtsProvider._({
    required ArticleTtsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'articleTtsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleTtsHash();

  @override
  String toString() {
    return r'articleTtsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleTts create() => ArticleTts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TtsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TtsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleTtsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleTtsHash() => r'35f7469fec6ab1110e705682e3582674ae625620';

final class ArticleTtsFamily extends $Family
    with
        $ClassFamilyOverride<ArticleTts, TtsState, TtsState, TtsState, String> {
  const ArticleTtsFamily._()
    : super(
        retry: null,
        name: r'articleTtsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleTtsProvider call(String articleId) =>
      ArticleTtsProvider._(argument: articleId, from: this);

  @override
  String toString() => r'articleTtsProvider';
}

abstract class _$ArticleTts extends $Notifier<TtsState> {
  late final _$args = ref.$arg as String;
  String get articleId => _$args;

  TtsState build(String articleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<TtsState, TtsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TtsState, TtsState>,
              TtsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
