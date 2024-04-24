import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';

abstract class GalleryRepository {
  Future<Either<Failure, List<String>>> getImages();
  Future<Either<Failure, Unit>> uploadImage(File image);
}
