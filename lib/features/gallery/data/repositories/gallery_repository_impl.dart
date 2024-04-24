import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';
import 'package:pro_mina_task/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:pro_mina_task/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl extends GalleryRepository {
  final GalleryRemoteDataSource galleryRemoteDataSource;

  GalleryRepositoryImpl({required this.galleryRemoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getImages() async {
    try {
      final imagesUrls = await galleryRemoteDataSource.getImages();
      return Right(imagesUrls);
    } catch (e) {
      return const Left(Failure(message: 'Getting Images Failed, Try again later'));
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadImage(File image) async {
    try {
       await galleryRemoteDataSource.uploadImage(image);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure(message: 'Uploading Image Failed, Try again later'));
    }
  }
}
