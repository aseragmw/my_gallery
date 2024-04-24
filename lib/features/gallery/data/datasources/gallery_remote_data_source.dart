import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pro_mina_task/core/constants/api_conatsants.dart';
import 'package:pro_mina_task/core/constants/app_constants.dart';
import 'package:pro_mina_task/core/network/api_caller.dart';

abstract class GalleryRemoteDataSource {
  Future<List<String>> getImages();
  Future<Unit> uploadImage(File image);
}

class GalleryRemoteDataSourceImplWithDio extends GalleryRemoteDataSource {
  @override
  Future<List<String>> getImages() async {
    final List<String> imagesUrls = [];
    final res = await ApiCaller.getHTTP("my-gallery", AppConstants.CachedCurrentUserObject![tokenAPI]);
    for (var image in res.data["data"]["images"]) {
      imagesUrls.add(image);
    }
    return imagesUrls;
  }

  @override
  Future<Unit> uploadImage(File image) async {
    FormData formData = FormData.fromMap({
        imgAPI: await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });
      await ApiCaller.postHTTP("upload", formData,AppConstants.CachedCurrentUserObject![tokenAPI]);
    return unit;
  }
}
