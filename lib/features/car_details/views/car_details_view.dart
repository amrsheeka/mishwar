import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/utils/contants.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_cubit.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_state.dart';
import 'package:mishwar/features/car_details/data/models/car_details_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetailsView extends StatefulWidget {
  final int id;
  const CarDetailsView({super.key, required this.id});

  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  late final PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => CarDetailsCubit()..getCarDetails(id: widget.id),
      child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
        builder: (context, state) {
          CarDetailsCubit cubit = context.read<CarDetailsCubit>();
          Car? car = cubit.carDetailsModel?.car;
          bool isLoading = state is GetCarDetailsLoadingState;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: Skeletonizer(
                enabled: isLoading,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Center(child: Icon(IconBroken.Arrow___Left)),
                ),
              ),
              actions: [
                Skeletonizer(
                  enabled: isLoading,
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: true ? (AppColors.surface) : AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Icon(
                            IconBroken.Heart,
                            color: isDark
                                ? AppColors.background
                                : AppColors.backgroundDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              title: Skeletonizer(
                enabled: isLoading,
                child: Text('${car?.brand.name} ${car?.model} ${car?.year}'),
              ),
            ),
            body: Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          child: PageView.builder(
                            itemCount: car?.images.length ?? 1,
                            controller: pageController,
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                pageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) => SizedBox(
                              height: 200,
                              width: double.maxFinite,
                              child: car == null
                                  ? Image.asset(defaultImage)
                                  : CachedNetworkImage(
                                      imageUrl: car.images[index].imageUrl,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              effect: ExpandingDotsEffect(
                                activeDotColor: AppColors.primary,
                              ),
                              onDotClicked: (index) {
                                pageController.jumpToPage(index);
                              },
                              activeIndex: pageIndex,
                              count: car?.images.length ?? 1,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {
                              pageController.previousPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            },
                            icon: Icon(IconBroken.Arrow___Left_2),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            },
                            icon: Icon(IconBroken.Arrow___Right_2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
