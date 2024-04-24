part of 'gallery_bloc.dart';

sealed class GalleryEvent extends Equatable {
  const GalleryEvent();
  @override
  List<Object> get props => [];
}

class GetImagesEvent extends GalleryEvent {}

class UploadImageEvent extends GalleryEvent {
  final File image;
  const UploadImageEvent({required this.image});
}
