import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/utils/toast.dart';
import 'package:mishwar/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:mishwar/features/auth/presentation/views/login_view.dart';
import 'package:mishwar/layouts/presentation/view_model/cubits/main_layout/main_layout_cubit.dart';
import 'package:mishwar/layouts/presentation/view_model/cubits/main_layout/main_layout_state.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
          MainLayoutCubit cubit = context.read<MainLayoutCubit>();
          final bool isDark = Theme.of(context).brightness == Brightness.dark;
          final Color backgroundColor = isDark
              ? AppColors.backgroundDark
              : AppColors.background;
          final Color surfaceColor = isDark
              ? AppColors.surfaceDark
              : AppColors.surface;
          final Color iconColor = isDark
              ? AppColors.background
              : AppColors.backgroundDark;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: backgroundColor,
              actions: [
                _AppBarAction(
                  icon: IconBroken.Search,
                  iconColor: iconColor,
                  surfaceColor: surfaceColor,
                  onPressed: () {
                    cubit.changeBottomNavBar(2);
                  },
                ),
                _AppBarAction(
                  icon: IconBroken.Notification,
                  iconColor: iconColor,
                  surfaceColor: surfaceColor,
                  onPressed: () {},
                ),
                BlocProvider(
                  create: (context) => AuthCubit(),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LogoutSucessState) {
                        showToast(
                          message: 'Logout Successfully',
                          type: ToastType.SUCCESS,
                        );
                        navigateAndFinish(
                          context: context,
                          page: const LoginView(),
                        );
                      }
                      if (state is LogoutErrorState) {
                        showToast(
                          message: 'Logout Failed',
                          type: ToastType.ERROR,
                        );
                      }
                    },
                    builder: (context, state) => _AppBarAction(
                      icon: IconBroken.Logout,
                      iconColor: AppColors.error,
                      surfaceColor: surfaceColor,
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              title: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('images/logo_name.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 0.8,
                selectedFontSize: 12,
                backgroundColor: AppColors.primary,
                selectedItemColor: AppColors.background,
                unselectedItemColor: AppColors.background.withValues(alpha: 0.58),
                showUnselectedLabels: false,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: AnimatedScale(
                      scale: cubit.currentIndex == 0 ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(IconBroken.Home),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedScale(
                      scale: cubit.currentIndex == 1 ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(IconBroken.Calendar),
                    ),
                    label: 'Appointments',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedScale(
                      scale: cubit.currentIndex == 2 ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(IconBroken.Search),
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedScale(
                      scale: cubit.currentIndex == 3 ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(IconBroken.Profile),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.08, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(cubit.currentIndex),
                child: cubit.screens[cubit.currentIndex],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppBarAction extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color surfaceColor;
  final VoidCallback onPressed;

  const _AppBarAction({
    required this.icon,
    required this.iconColor,
    required this.surfaceColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: surfaceColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 21),
        ),
      ),
    );
  }
}
