// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPostsHash() => r'd42472e679ed67b30ee8c3795ab381feb0ef81aa';

/// See also [fetchPosts].
@ProviderFor(fetchPosts)
final fetchPostsProvider = AutoDisposeFutureProvider<List<PostModel>>.internal(
  fetchPosts,
  name: r'fetchPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchPostsRef = AutoDisposeFutureProviderRef<List<PostModel>>;
String _$postViewModelHash() => r'b7b9c0c8a8befafd2026df039b1c14c009581d1e';

/// See also [PostViewModel].
@ProviderFor(PostViewModel)
final postViewModelProvider =
    AutoDisposeNotifierProvider<PostViewModel, AsyncValue?>.internal(
  PostViewModel.new,
  name: r'postViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
