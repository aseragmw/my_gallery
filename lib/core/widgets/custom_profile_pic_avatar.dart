import 'package:flutter/material.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';

class CustomProfilePicAvatar extends StatelessWidget {
  const CustomProfilePicAvatar({super.key, required this.radius, required this.imagePath, required this.showChangeImage});
  final double radius;
  final String imagePath;
  final bool showChangeImage;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CircleAvatar(
        radius: radius, // Adjust the radius as needed
        backgroundImage: AssetImage(imagePath), // Add your profile picture asset here
      ),
      showChangeImage
          ? Positioned(
              top: radius * 1.45,
              left: radius * 1.45,
              child: InkWell(
                onTap: () {
                  //TODO add logic
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppTheme.primaryGreenColor,
                    ),
                    padding: EdgeInsets.all(radius / 11),
                    child: const Icon(Icons.edit)),
              ))
          : const SizedBox(),
    ]);
  }
}
