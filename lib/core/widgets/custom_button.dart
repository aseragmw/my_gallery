import 'package:flutter/material.dart';
import 'package:pro_mina_task/core/extentions/screen_size.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.buttonColor,
      required this.borderRadius,
      required this.borderColor,
      required this.buttonWidth,
      required this.fontSize,
      this.buttonHeight,
      this.fontColor});
  final String title;
  final Function() onPress;
  final Color? buttonColor;
  final Color? borderColor;

  final BorderRadius? borderRadius;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? fontColor;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        onPress.call();
      },
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor ?? Colors.transparent,
            borderRadius: borderRadius ?? AppTheme.boxRadius,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        width: buttonWidth ?? context.screenWidth * 0.8,
        height: buttonHeight ?? context.screenHeight * 0.07,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: AppTheme.fontWeight500, color: fontColor ?? Colors.white, fontSize: fontSize ?? AppTheme.fontSize18(context)),
          ),
        ),
      ),
    );
  }
}
