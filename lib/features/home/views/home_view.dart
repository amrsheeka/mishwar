import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/widgets/default_car_card.dart';
import 'package:mishwar/core/widgets/default_text_field.dart';
import 'package:mishwar/features/home/cubits/home_cubit.dart';
import 'package:mishwar/features/home/cubits/home_state.dart';
import 'package:mishwar/features/home/views/widgets/brand_item.dart';
import 'package:mishwar/layouts/presentation/view_model/cubits/main_layout/main_layout_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<HomeCubit>().loadMoreFeaturedCars();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.background;
    final Color surfaceColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surface;
    return ColoredBox(
      color: backgroundColor,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, User!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Find a ride that fits your next trip.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),

          /// SEARCH BAR
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                color: AppColors.backgroundDark.withValues(alpha: 0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    context.read<MainLayoutCubit>().changeBottomNavBar(2);
                  },
                  child: IgnorePointer(
                    child: DefaultTextField(
                      controller: null,
                      enabled: false,
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        IconBroken.Search,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 18)),

          /// CAROUSEL + INDICATOR
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();

              final isLoading = cubit.slider.isEmpty;

              return SliverToBoxAdapter(
                child: Skeletonizer(
                  enabled: isLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        /// CAROUSEL
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CarouselSlider(
                            items: cubit.slider.map((e) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: e,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: surfaceColor,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline_rounded,
                                      color: AppColors.error,
                                    ),
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.backgroundDark.withValues(
                                            alpha: 0,
                                          ),
                                          AppColors.backgroundDark.withValues(
                                            alpha: 0.24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                        ),

                        const SizedBox(height: 10),

                        /// INDICATOR (separate rebuild)
                        AnimatedSmoothIndicator(
                          activeIndex: cubit.sliderIndex,
                          count: cubit.slider.isEmpty ? 1 : cubit.slider.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: AppColors.primary,
                            dotColor: AppColors.surface,
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SliverAppBar(
            pinned: true,
            expandedHeight: 58.0,
            backgroundColor: backgroundColor,
            elevation: 0,
            titleSpacing: 0,
            title: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: backgroundColor,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  final isLoading = state is GetFeaturedCarsLoadingState;

                  final itemCount = isLoading
                      ? 5
                      : cubit.brandsModel?.brands.length ?? 0;

                  return Skeletonizer(
                    enabled: isLoading,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final brand = isLoading
                              ? null
                              : cubit.brandsModel?.brands[index];
                          return BrandItem(
                            id: cubit.brandsModel?.brands[index].id ?? 1,
                            index: index,
                            imageUrl: brand?.logo ?? '',
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: itemCount,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Featured Cars',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                        child: Row(
                          children: [
                            const Text('See All'),
                            Icon(IconBroken.Arrow___Right_2, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final cubit = context.read<HomeCubit>();

                      final isInitialLoading =
                          state is GetFeaturedCarsLoadingState;

                      final isLoadingMore =
                          state is GetMoreFeaturedCarsLoadingState;

                      final cars = cubit.featuredCarsModel?.cars.data ?? [];
                      final itemCount = isInitialLoading
                          ? 5
                          : cars.length + (isLoadingMore ? 1 : 0);

                      Widget buildCarCard(int index) {
                        if (isLoadingMore && index == cars.length) {
                          return Skeletonizer(
                            enabled: true,
                            child: const DefaultCarCard(
                              id: 0,
                              index: -1,
                              imageUrl: '',
                              brandName: 'Brand',
                              model: 'Model',
                              year: '2026',
                              seats: 4,
                              fuelType: 'Fuel',
                              transmission: 'Auto',
                              pricePerDay: 0,
                              reviewsAvgRating: 0,
                            ),
                          );
                        }

                        final car = isInitialLoading ? null : cars[index];

                        return DefaultCarCard(
                          id: car?.id ?? 0,
                          index: index,
                          imageUrl: car?.primaryImage.imageUrl ?? '',
                          brandName: car?.brand.name ?? 'Brand',
                          model: car?.model ?? 'Model',
                          year: car?.year ?? '2026',
                          seats: car?.seats ?? 4,
                          fuelType: car?.fuelType ?? 'Fuel',
                          transmission: car?.transmission ?? 'Auto',
                          pricePerDay: car?.pricePerDay ?? 0,
                          reviewsAvgRating: car?.reviewsAvgRating ?? 0,
                        );
                      }

                      return Skeletonizer(
                        enabled: isInitialLoading,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final int crossAxisCount =
                                constraints.maxWidth >= 720 ? 2 : 1;

                            if (crossAxisCount == 1) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: itemCount,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) =>
                                    buildCarCard(index),
                              );
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: itemCount,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14,
                                    childAspectRatio: 1.05,
                                  ),
                              itemBuilder: (context, index) =>
                                  buildCarCard(index),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
