import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/features/appointments/views/appointments_view.dart';
import 'package:mishwar/features/home/cubits/home_cubit.dart';

import 'package:mishwar/features/home/views/home_view.dart';
import 'package:mishwar/features/profile/views/profile_view.dart';
import 'package:mishwar/features/search/views/search_view.dart';
import 'package:mishwar/layouts/presentation/view_model/cubits/main_layout/main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitialState());

  List<Widget> screens = [
    BlocProvider(
      create: (_) => HomeCubit()
        ..getFeaturedCars()
        ..getBrands(),
      child: const HomeView(),
    ),
    const AppointmentsView(),
    const SearchView(),
    const ProfileView(),
  ];
  int currentIndex = 0;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(MainLayoutChangeBottomNavBarState());
  }
}
