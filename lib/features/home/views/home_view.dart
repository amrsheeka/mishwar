import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/widgets/default_car_card.dart';
import 'package:mishwar/features/home/cubits/home_cubit.dart';
import 'package:mishwar/features/home/cubits/home_state.dart';
import 'package:mishwar/features/home/views/widgets/brand_item.dart';
import 'package:mishwar/layouts/presentation/view_model/cubits/main_layout/main_layout_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()
        ..getFeaturedCars()
        ..getBrands(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// HEADER
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Welcome back, User!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            /// SEARCH BAR
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  context.read<MainLayoutCubit>().changeBottomNavBar(2);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(IconBroken.Search, color: AppColors.grey),
                      SizedBox(width: 10),
                      Text('Search', style: TextStyle(color: AppColors.grey)),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            /// CAROUSEL + INDICATOR
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();

                final isLoading = cubit.slider.isEmpty;

                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Column(
                      children: [
                        /// CAROUSEL
                        CarouselSlider(
                          items: cubit.slider.map((e) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: CachedNetworkImage(
                                imageUrl: e,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.grey.withValues(alpha: 0.3),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error, color: Colors.red),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: false,
                            viewportFraction: 1.0,
                            aspectRatio: 1.9,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            onPageChanged: (index, reason) {
                              cubit.changeSliderIndex(index);
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// INDICATOR (separate rebuild)
                        AnimatedSmoothIndicator(
                          activeIndex: cubit.sliderIndex,
                          count: cubit.slider.isEmpty ? 1 : cubit.slider.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
            SliverAppBar(
              pinned: true,
              expandedHeight: 40.0,
              titleSpacing: 0,
              title: SizedBox(
                height: 40,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final cubit = context.read<HomeCubit>();
                    return Skeletonizer(
                      enabled: state is GetBrandsLoadingState,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => BrandItem(
                          index: index,
                          imageUrl: cubit.brandsModel!.brands.data[index].logo,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: cubit.brandsModel != null
                            ? cubit.brandsModel!.brands.data.length
                            : 0,
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Featured Cars',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Text('See All'),
                            Icon(IconBroken.Arrow___Right_2, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final cubit = context.read<HomeCubit>();
                      return Skeletonizer(
                        enabled: state is GetFeaturedCarsLoadingState,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => DefaultCarCard(
                            index: index,
                            imageUrl: cubit
                                .featuredCarsModel!
                                .cars
                                .data[index]
                                .primaryImage
                                .imageUrl,
                            brandName: cubit
                                .featuredCarsModel!
                                .cars
                                .data[index]
                                .brand
                                .name,
                            model:
                                cubit.featuredCarsModel!.cars.data[index].model,
                            year:
                                cubit.featuredCarsModel!.cars.data[index].year,
                            seats: cubit.featuredCarsModel!.cars.data[index].seats,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: cubit.featuredCarsModel != null
                              ? cubit.featuredCarsModel!.cars.data.length
                              : 0,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
