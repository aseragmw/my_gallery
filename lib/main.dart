import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina_task/core/constants/app_constants.dart';
import 'package:pro_mina_task/core/utils/cache_helper.dart';
import 'package:pro_mina_task/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:pro_mina_task/features/auth/presentation/screens/login_screen.dart';
import 'package:pro_mina_task/features/gallery/presentation/bloc/bloc/gallery_bloc.dart';
import 'package:pro_mina_task/features/gallery/presentation/screens/gallery_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  AppConstants.initAppConstants();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => GalleryBloc(),
      )
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Gallery',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AppConstants.CachedCurrentUserObject ==null? LoginScreen():const GalleryScreen()),
    );
  }
}
