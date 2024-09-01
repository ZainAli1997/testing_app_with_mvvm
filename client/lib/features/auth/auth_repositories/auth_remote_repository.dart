import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testing_app_with_mvvm/core/models/user_model.dart';
import 'package:testing_app_with_mvvm/core/utils/failure.dart';
import 'package:testing_app_with_mvvm/core/utils/server_constant.dart';
import 'package:testing_app_with_mvvm/core/utils/type_defs.dart';
import 'package:http/http.dart' as http;

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
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
}