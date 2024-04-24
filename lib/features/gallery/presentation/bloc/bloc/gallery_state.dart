part of 'gallery_bloc.dart';

sealed class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

final class GalleryInitial extends GalleryState {}

class GetImagesLoadingState extends GalleryState {}

class GetImagesErrorState extends GalleryState {
  final String message;

  const GetImagesErrorState({required this.message});
}

class GetImagesSuccessState extends GalleryState {
  final List<String> imagesUrls;

  const GetImagesSuccessState({required this.imagesUrls});
}

class UploadImageLoadingState extends GalleryState {}

class UploadImageErrorState extends GalleryState {
  final String message;

  const UploadImageErrorState({required this.message});
}

class UploadImageSuccessState extends GalleryState {}
