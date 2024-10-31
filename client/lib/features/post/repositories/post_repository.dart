import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testing_app_with_mvvm/core/utils/failure.dart';
import 'package:testing_app_with_mvvm/core/utils/server_constant.dart';
import 'package:testing_app_with_mvvm/core/utils/type_defs.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app_with_mvvm/features/post/models/post_model.dart';
part 'post_repository.g.dart';

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepository();
}

class PostRepository {
  FutureEither<PostModel> addPost({
    required String title,
    required File? image,
    required Uint8List? webImage,
    required String description,
    required String token,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('djs5chzt2', 'znsxkcdy');

      final String imageUrl;

      final String uniqueIdentifier =
          'web_image_${DateTime.now().millisecondsSinceEpoch}';

      if (kIsWeb) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(
            webImage!,
            folder: title,
            identifier: uniqueIdentifier,
          ),
        );
        imageUrl = res.secureUrl;
      } else {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image!.path,
            folder: title,
          ),
        );
        imageUrl = res.secureUrl;
      }

      final response = await http.post(
        Uri.parse(
          '$serverURL/posts/add',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {
            'createdAt': DateTime.now().millisecondsSinceEpoch,
            'title': title,
            'image': imageUrl,
            'description': description,
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }
      return Right(
        PostModel.fromMap(resBodyMap),
      );
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$serverURL/posts',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var resBodyMap = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }
      resBodyMap = resBodyMap as List;
      List<PostModel> posts = [];
      for (final map in resBodyMap) {
        posts.add(PostModel.fromMap(map));
      }
      return Right(posts);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
