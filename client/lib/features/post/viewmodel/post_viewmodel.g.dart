// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPostsHash() => r'f13ee771c7ebd200b099f093c174e089d28392e1';

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

String _$postViewModelHash() => r'ccde064affef14d1cb294d5a5b1ceab810195d76';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
