import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testing_app_with_mvvm/core/utils/constants.dart';
import 'package:testing_app_with_mvvm/core/utils/failure.dart';
import 'package:testing_app_with_mvvm/core/utils/type_defs.dart';

part 'storage_repository_provider.g.dart';

@riverpod
StorageRepository storageRepository(Ref ref) {
  return StorageRepository();
}

class StorageRepository {
  FutureEither<String> storeFile({
    required File? file,
    required Uint8List? webFile,
    String? folder,
  }) async {
    try {
      final cloudinary = CloudinaryPublic(
        CloudinaryConstants.cloudName,
        CloudinaryConstants.uploadPreset,
      );
      final String imageUrl;

      final String uniqueIdentifier =
          'web_image_${DateTime.now().millisecondsSinceEpoch}';

      if (kIsWeb) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(
            webFile!,
            folder: folder,
            identifier: uniqueIdentifier,
          ),
        );
        imageUrl = res.secureUrl;
      } else {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            file!.path,
            folder: folder,
          ),
        );
        imageUrl = res.secureUrl;
      }

      return Right(await imageUrl);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
