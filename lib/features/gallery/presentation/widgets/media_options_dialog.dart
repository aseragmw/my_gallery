import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_task/core/extentions/screen_size.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';
import 'package:pro_mina_task/core/utils/snackbar_message.dart';
import 'package:pro_mina_task/core/widgets/custom_circular_progress_indicator.dart';
import 'package:pro_mina_task/features/gallery/presentation/bloc/bloc/gallery_bloc.dart';
import 'package:pro_mina_task/features/gallery/presentation/widgets/button_with_image.dart';

class MediaOptionsDialog extends StatelessWidget {
  const MediaOptionsDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(),
      child: Dialog(
        elevation: 0,
        surfaceTintColor: AppTheme.transparentColor,
        backgroundColor: AppTheme.transparentColor,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
                height: context.screenHeight * 0.3,
                decoration: BoxDecoration(
                    borderRadius: AppTheme.boxRadius, color: Colors.white.withOpacity(0.3), border: Border.all(color: AppTheme.whiteColor)),
                padding: EdgeInsets.all(context.screenWidth * 0.07),
                width: context.screenWidth * 0.85,
                child: BlocConsumer<GalleryBloc, GalleryState>(
                  builder: (context, state) {
                    if (state is UploadImageLoadingState) {
                      return const Center(child: CustomCircularProgressIndicator(color: AppTheme.lightBlueColor));
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ButtonWithImage(
                            title: 'Gallery',
                            imgPath: 'assets/gallery.png',
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                context.read<GalleryBloc>().add(UploadImageEvent(image: File(pickedFile.path)));
                              }
                            },
                            buttonColor: AppTheme.mauveColor,
                            iconColor: AppTheme.mauveColor,
                            buttonHeight: context.screenWidth * 0.15,
                          ),
                          SizedBox(
                            height: context.screenHeight * 0.03,
                          ),
                          ButtonWithImage(
                            title: 'Camera',
                            imgPath: 'assets/camera.png',
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(source: ImageSource.camera);
                              if (pickedFile != null) {
                                context.read<GalleryBloc>().add(UploadImageEvent(image: File(pickedFile.path)));
                              }
                            },
                            buttonColor: AppTheme.iceColor,
                            iconColor: AppTheme.iceColor,
                            buttonHeight: context.screenWidth * 0.15,
                          ),
                        ],
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is UploadImageSuccessState) {
                      SnackBarMessage.showSuccessSnackBar(message: "Image Uploaded", context: context);
                      context.read<GalleryBloc>().add(GetImagesEvent());

                      Navigator.of(context).pop();
                    } else if (state is UploadImageErrorState) {
                      SnackBarMessage.showErrorSnackBar(message: state.message, context: context);
                    }
                  },
                )),
          ),
        ),
      ),
    );
  }
}
