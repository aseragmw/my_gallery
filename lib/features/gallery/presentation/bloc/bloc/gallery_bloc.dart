import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_mina_task/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:pro_mina_task/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:pro_mina_task/features/gallery/domain/usecases/get_images_usecase.dart';
import 'package:pro_mina_task/features/gallery/domain/usecases/upload_image_usecase.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitial()) {
    on<GalleryEvent>((event, emit) {});

    on<GetImagesEvent>(
      (event, emit) async {
        emit(GetImagesLoadingState());
        GetImagesUsecase getImagesUsecase =
            GetImagesUsecase(galleryRepository: GalleryRepositoryImpl(galleryRemoteDataSource: GalleryRemoteDataSourceImplWithDio()));
        final either = await getImagesUsecase.call();
        either.fold((l) {
          emit(GetImagesErrorState(message: l.message));
        }, (r) => emit(GetImagesSuccessState(imagesUrls: r)));
      },
    );

    on<UploadImageEvent>(
      (event, emit) async {
        emit(UploadImageLoadingState());
      UploadImageUsecase uploadImageUsecase =
            UploadImageUsecase(galleryRepository: GalleryRepositoryImpl(galleryRemoteDataSource: GalleryRemoteDataSourceImplWithDio()));
        final either = await uploadImageUsecase.call(event.image);
        either.fold((l) => emit(UploadImageErrorState(message: l.message)), (r) => emit(UploadImageSuccessState()));
      },
    );
  }
}
