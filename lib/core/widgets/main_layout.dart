import 'package:flutter/material.dart';
import 'package:pro_mina_task/core/utils/app_theme.dart';

class MainLayout extends StatelessWidget {
  const MainLayout(
      {super.key, required this.body, this.bottomNavBar, this.floatingActionButtonLocation, this.floatingActionButton, this.singleChild});
  final Widget body;
  final Widget? bottomNavBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final bool? singleChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/login.png"), fit: BoxFit.cover)),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomNavBar,
        floatingActionButton: floatingActionButton,
        backgroundColor: AppTheme.transparentColor,
        body: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: (singleChild != null && singleChild == false) ? body : SingleChildScrollView(child: Center(child: body))),
        ),
      ),
    );
  }
}
