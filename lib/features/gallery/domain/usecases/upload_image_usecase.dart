import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';
import 'package:pro_mina_task/features/gallery/domain/repositories/gallery_repository.dart';

class UploadImageUsecase {
  final GalleryRepository galleryRepository;

  UploadImageUsecase({required this.galleryRepository});
  Future<Either<Failure, Unit>> call(File image) => galleryRepository.uploadImage(image);
}
