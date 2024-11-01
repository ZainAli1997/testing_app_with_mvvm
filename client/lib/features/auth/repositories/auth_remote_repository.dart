import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testing_app_with_mvvm/core/models/user_model.dart';
import 'package:testing_app_with_mvvm/core/utils/failure.dart';
import 'package:testing_app_with_mvvm/core/utils/server_constant.dart';
import 'package:testing_app_with_mvvm/core/utils/type_defs.dart';
import 'package:http/http.dart' as http;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  FutureEither<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$serverURL/api/signup',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
            'profileImage': '',
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body);

      if (response.statusCode == 400) {
        return Left(Failure(resBodyMap['msg']));
      } else if (response.statusCode == 500) {
        return Left(Failure(resBodyMap['error']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$serverURL/api/signin',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body);

      if (response.statusCode == 400) {
        return Left(Failure(resBodyMap['msg']));
      } else if (response.statusCode == 500) {
        return Left(Failure(resBodyMap['error']));
      }

      return Right(
        UserModel.fromMap(resBodyMap['user']).copyWith(
          token: resBodyMap['token'],
        ),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> getCurrentUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$serverURL/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }

      return Right(
        UserModel.fromMap(resBodyMap['user']).copyWith(
          token: token,
        ),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> getUserById(String id, String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$serverURL/user/$id',
        ),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );
      final resBodyMap = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }
      return Right(
        UserModel.fromMap(resBodyMap),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> editProfile(
    String id,
    String newName,
    File? profileImage,
    Uint8List? webProfileImage,
    String token,
  ) async {
    try {
      final cloudinary = CloudinaryPublic('djs5chzt2', 'znsxkcdy');

      final String imageUrl;

      final String uniqueIdentifier =
          'web_image_${DateTime.now().millisecondsSinceEpoch}';

      if (kIsWeb) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(
            webProfileImage!,
            folder: newName,
            identifier: uniqueIdentifier,
          ),
        );
        imageUrl = res.secureUrl;
      } else {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            profileImage!.path,
            folder: newName,
          ),
        );
        imageUrl = res.secureUrl;
      }
      final response = await http.put(
        Uri.parse('$serverURL/updateUser/$id'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token, // Include the token in headers
        },
        body: jsonEncode({
          'name': newName,
          'profileImage': imageUrl,
        }),
      );

      final resBodyMap = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['message'] ?? 'Error updating user'));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
