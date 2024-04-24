import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina_task/core/constants/api_conatsants.dart';
import 'package:pro_mina_task/core/constants/app_constants.dart';
import 'package:pro_mina_task/core/constants/cache_constants.dart';
import 'package:pro_mina_task/core/extentions/screen_size.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';
import 'package:pro_mina_task/core/utils/cache_helper.dart';
import 'package:pro_mina_task/core/utils/snackbar_message.dart';
import 'package:pro_mina_task/core/widgets/custom_circular_progress_indicator.dart';
import 'package:pro_mina_task/core/widgets/custom_profile_pic_avatar.dart';
import 'package:pro_mina_task/core/widgets/main_layout.dart';
import 'package:pro_mina_task/features/auth/presentation/screens/login_screen.dart';
import 'package:pro_mina_task/features/gallery/presentation/bloc/bloc/gallery_bloc.dart';
import 'package:pro_mina_task/features/gallery/presentation/widgets/button_with_image.dart';
import 'package:pro_mina_task/features/gallery/presentation/widgets/media_options_dialog.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GalleryBloc>().add(GetImagesEvent());
    return MainLayout(
        body: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.boxRadius,
          color: Colors.white.withOpacity(0.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05, vertical: context.screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome\n${AppConstants.CachedCurrentUserObject![nameAPI]}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: AppTheme.fontSize20(context), fontWeight: FontWeight.bold, color: AppTheme.darkGreyColor),
                ),
                CustomProfilePicAvatar(radius: context.screenAspectRatio * 18, imagePath: "assets/profile_pic.png", showChangeImage: false),
              ],
            ),
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWithImage(
                  title: 'log out',
                  imgPath: "assets/back_arrow.png",
                  onTap: () {
                    CacheHelper.remove(currentUserCache);
                    AppConstants.CachedCurrentUserObject = null;
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                  },
                  iconColor: AppTheme.redColor,
                ),
                ButtonWithImage(
                  title: 'upload',
                  imgPath: "assets/up_arrow.png",
                  onTap: () async {
                    await showGeneralDialog(
                      context: context,
                      barrierColor: AppTheme.transparentColor,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const MediaOptionsDialog();
                      },
                    );
                    context.read<GalleryBloc>().add(GetImagesEvent());
                  },
                  iconColor: AppTheme.orangeColor,
                )
              ],
            ),
            SizedBox(
              height: context.screenHeight * 0.03,
            ),
            BlocConsumer<GalleryBloc, GalleryState>(
              builder: (context, state) {
                if (state is GetImagesLoadingState) {
                  return const CustomCircularProgressIndicator(color: AppTheme.lightBlueColor);
                } else if (state is GetImagesSuccessState) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
                    itemCount: state.imagesUrls.length,
                    itemBuilder: (context, index) {
                      
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
       imageUrl: state.imagesUrls[index],
       progressIndicatorBuilder: (context, url, downloadProgress) => 
               CircularProgressIndicator(value: downloadProgress.progress,color: AppTheme.lightBlueColor,),
       errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
                        
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Text(
                    "No Images Yet.",
                    style: TextStyle(fontSize: AppTheme.fontSize18(context), fontWeight: FontWeight.bold, color: AppTheme.darkGreyColor),
                  ));
                }
              },
              listener: (context, state) {
                if (state is GetImagesErrorState) {
                  SnackBarMessage.showErrorSnackBar(message: state.message, context: context);
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
