import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
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
          return Scaffold(
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
                selectedItemColor: Colors.white,
                unselectedItemColor: AppColors.grey,
                showUnselectedLabels: false,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items:  [
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
                      child: Icon(IconBroken.Calendar)),
                    label: 'Appointments',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedScale(
                      scale: cubit.currentIndex == 2 ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(IconBroken.Search),
                    
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedScale(
                      scale: cubit.currentIndex == 3 ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(IconBroken.Profile),
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
