import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testing_app_with_mvvm/core/providers/current_user_notifier.dart';
import 'package:testing_app_with_mvvm/features/post/models/post_model.dart';
import 'package:testing_app_with_mvvm/features/post/repositories/post_repository.dart';

part 'post_viewmodel.g.dart';

@riverpod
Future<List<PostModel>> fetchPosts(Ref ref) async {
  final res = await ref.watch(postRepositoryProvider).fetchPosts();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class PostViewModel extends _$PostViewModel {
  late PostRepository _postRepository;
  @override
  AsyncValue? build() {
    _postRepository = ref.watch(postRepositoryProvider);
    return null;
  }

  Future<void> addPost({
    required String title,
    required String description,
    required File? image,
    required Uint8List? webImage,
  }) async {
    state = const AsyncValue.loading();
    final res = await _postRepository.addPost(
      title: title,
      image: image,
      webImage: webImage,
      description: description,
      token: ref.read(currentUserNotifierProvider)!.token,
    );
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    ref.invalidate(fetchPostsProvider);
    print(val);
  }
}
