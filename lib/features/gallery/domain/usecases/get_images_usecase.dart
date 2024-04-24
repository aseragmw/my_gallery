import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';
import 'package:pro_mina_task/features/gallery/domain/repositories/gallery_repository.dart';

class GetImagesUsecase {
  final GalleryRepository galleryRepository;

  GetImagesUsecase({required this.galleryRepository});
  Future<Either<Failure, List<String>>> call() => galleryRepository.getImages();
}
