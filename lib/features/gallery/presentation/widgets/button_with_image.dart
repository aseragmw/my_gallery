import 'package:flutter/material.dart';
import 'package:pro_mina_task/core/extentions/screen_size.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';

class ButtonWithImage extends StatelessWidget {
  const ButtonWithImage(
      {super.key, required this.title, required this.imgPath, required this.onTap, this.buttonColor, this.buttonHeight, this.buttonWidth, this.iconColor});
  final String title;
  final String imgPath;
  final Function() onTap;
  final Color? buttonColor;
    final Color? iconColor;

  final double? buttonHeight;
  final double? buttonWidth;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.white.withOpacity(0.70),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: buttonHeight ?? context.screenWidth * 0.1,
        width: buttonWidth ?? context.screenWidth * 0.33,
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                          color: iconColor ?? Colors.white.withOpacity(0.70),

                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                imgPath,
                height: buttonHeight != null ? buttonHeight! * 0.6 : context.screenWidth * 0.07,
                width: buttonHeight != null ? buttonHeight! * 0.6 : context.screenWidth * 0.07,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: AppTheme.fontSize16(context), fontWeight: FontWeight.bold, color: AppTheme.darkGreyColor),
            )
          ],
        ),
      ),
    );
  }
}
