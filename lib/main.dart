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
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final Widget initialScreen;
    if (token == null) {
      initialScreen = const LoginView();
    } else {
      initialScreen = const MainLayout();
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
          foregroundColor: AppColors.backgroundDark,
          elevation: 0,
          centerTitle: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.grey;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.primary.withValues(alpha: 0.28)
                : AppColors.surface;
          }),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: AppColors.surface,
          thumbColor: AppColors.primary,
          overlayColor: AppColors.primary.withValues(alpha: 0.14),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          hintStyle: const TextStyle(color: AppColors.grey),
          labelStyle: const TextStyle(color: AppColors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
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
          foregroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.secondary),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.secondary
                : AppColors.grey;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? AppColors.secondary.withValues(alpha: 0.24)
                : AppColors.surfaceDark;
          }),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.secondary,
          inactiveTrackColor: AppColors.surfaceDark,
          thumbColor: AppColors.secondary,
          overlayColor: AppColors.secondary.withValues(alpha: 0.14),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceDark,
          hintStyle: const TextStyle(color: AppColors.grey),
          labelStyle: const TextStyle(color: AppColors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.secondary, width: 2),
          ),
        ),
      ),

      // Use system theme
      themeMode: ThemeMode.light,

      home: initialScreen,
    );
  }
}
