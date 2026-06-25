import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/cach_helper.dart';
import 'package:mishwar/core/utils/dio_helper.dart';
import 'package:mishwar/features/auth/presentation/views/login_view.dart';
import 'package:mishwar/features/auth/presentation/views/signup_view.dart';
// import 'package:mishwar/core/utils/services.dart';

import 'package:mishwar/layouts/presentation/views/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  DioHelper.init();
  
  await CacheHelper.init();
  String? token = CacheHelper.getData(key: 'token');
  runApp(MyApp(token: token,));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key,required this.token});
  
  @override
  Widget build(BuildContext context) {
    final Widget initialScreen;
    if(token==null){
      initialScreen = LoginView();
    }else{
      initialScreen = MainLayout();
    }
    return MaterialApp(
      title: 'Mishwar',
      debugShowCheckedModeBanner: false,
      
      // Light Theme
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.stackSansNotchTextTheme(),
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: Colors.black,
          elevation: 0,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,

        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surfaceDark,
          error: AppColors.error,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundDark,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),

      // Use system theme
      themeMode: ThemeMode.light,

      home: initialScreen,
    );
  }
}
