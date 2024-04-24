import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina_task/core/extentions/screen_size.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';
import 'package:pro_mina_task/core/utils/snackbar_message.dart';
import 'package:pro_mina_task/core/widgets/custom_button.dart';
import 'package:pro_mina_task/core/widgets/custom_circular_progress_indicator.dart';
import 'package:pro_mina_task/core/widgets/custom_text_field.dart';
import 'package:pro_mina_task/core/widgets/main_layout.dart';
import 'package:pro_mina_task/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:pro_mina_task/features/gallery/presentation/bloc/bloc/gallery_bloc.dart';
import 'package:pro_mina_task/features/gallery/presentation/screens/gallery_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05, vertical: context.screenWidth * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.screenHeight * 0.125,
          ),
          Text(
            "My\nGallery",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: AppTheme.fontSize40(context), fontWeight: FontWeight.bold, color: AppTheme.darkGreyColor),
          ),
          SizedBox(
            height: context.screenHeight * 0.05,
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppTheme.boxRadius,
                  color: Colors.white.withOpacity(0.3),
                ),
                padding: EdgeInsets.all(context.screenWidth * 0.07),
                width: context.screenWidth * 0.85,
                child: Column(
                  children: [
                    Text(
                      "LOG IN",
                      style: TextStyle(fontSize: AppTheme.fontSize30(context), fontWeight: FontWeight.bold, color: AppTheme.darkGreyColor),
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.04,
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.06,
                      child: CustomTextField(
                        hintText: "Email",
                        trailingIcon: null,
                        obsecured: false,
                        controller: emailController,
                        filled: true,
                        fillColor: AppTheme.whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.04,
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.06,
                      child: CustomTextField(
                        hintText: "Password",
                        trailingIcon: null,
                        obsecured: true,
                        controller: passwordController,
                        filled: true,
                        fillColor: AppTheme.whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.04,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const CustomCircularProgressIndicator(color: AppTheme.lightBlueColor);
                        } else {
                          return CustomButton(
                            title: 'Submit',
                            onPress: () {
                              if (emailController.text.isEmpty) {
                                SnackBarMessage.showErrorSnackBar(message: "Email is required", context: context);
                                return;
                              }
                              if (passwordController.text.isEmpty) {
                                SnackBarMessage.showErrorSnackBar(message: "Password is required", context: context);
                                return;
                              }
                              context.read<AuthBloc>().add(LoginEvent(email: emailController.text, password: passwordController.text));
                            },
                            buttonColor: AppTheme.lightBlueColor,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            borderColor: AppTheme.lightBlueColor,
                            buttonWidth: context.screenWidth * 0.86,
                            fontSize: AppTheme.fontSize20(context),
                            buttonHeight: context.screenHeight * 0.06,
                          );
                        }
                      },
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          SnackBarMessage.showSuccessSnackBar(message: "Login Success", context: context);
                          context.read<GalleryBloc>().add(GetImagesEvent());

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const GalleryScreen(),
                              ),
                              (route) => false);
                        } else if (state is LoginErrorState) {
                          SnackBarMessage.showErrorSnackBar(message: state.message, context: context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
