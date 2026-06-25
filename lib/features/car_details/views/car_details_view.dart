import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/models/car.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_cubit.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_state.dart';
import 'package:mishwar/features/car_details/data/models/car_details_model.dart';
import 'package:mishwar/features/car_details/views/widgets/car_preview.dart';
import 'package:mishwar/features/car_details/views/widgets/description_card.dart';
import 'package:mishwar/features/car_details/views/widgets/quick_info_card.dart';
import 'package:mishwar/features/car_details/views/widgets/reviews_section.dart';
import 'package:mishwar/features/car_details/views/widgets/specification_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarDetailsView extends StatefulWidget {
  final int id;
  const CarDetailsView({super.key, required this.id});

  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.background;
    final Color surfaceColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surface;
    final Color textColor = isDark
        ? AppColors.background
        : AppColors.backgroundDark;

    return BlocProvider(
      create: (context) => CarDetailsCubit()
        ..getCarDetails(id: widget.id)
        ..getReviews(id: widget.id),
      child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
        builder: (context, state) {
          CarDetailsCubit cubit = context.read<CarDetailsCubit>();
          Car? car = cubit.carDetailsModel?.car;
          bool isLoading = cubit.isCarLoading;
          bool isReviewsLoading = cubit.isReviewsLoading;
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: backgroundColor,
              elevation: 0,
              leading: Skeletonizer(
                enabled: isLoading,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: surfaceColor,
                    ),
                    child: Icon(
                      IconBroken.Arrow___Left,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              actions: [
                //todo
                Skeletonizer(
                  enabled: isLoading,
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: surfaceColor,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          IconBroken.Heart,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              title: Skeletonizer(
                enabled: isLoading,
                child: Text(
                  '${car?.brand.name} ${car?.model} ${car?.year}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            body: Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarPreview(car: car),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          quickInfoCard(car: car),
                          const SizedBox(height: 22),
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
                                'Specification',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              int crossAxisCount = constraints.maxWidth < 600
                                  ? 2
                                  : 4;

                              return GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1.4,
                                children: [
                                  SpecificationItem(
                                    title: 'Number of seats',
                                    icon: Icons.chair_sharp,
                                    value: '${car?.seats}',
                                  ),
                                  SpecificationItem(
                                    title: 'Fuel type',
                                    icon: Icons.propane_tank_sharp,
                                    value: '${car?.fuelType}',
                                  ),
                                  SpecificationItem(
                                    title: 'Color',
                                    icon: Icons.color_lens_rounded,
                                    value: '${car?.color}',
                                  ),
                                  SpecificationItem(
                                    title: 'Transmission',
                                    icon: Icons.drive_eta_sharp,
                                    value: '${car?.transmission}',
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 22),
                          descriptionCard(context, car?.description ?? ''),
                          const SizedBox(height: 22),
                          Skeletonizer(
                            enabled: isReviewsLoading,
                            child: ReviewsSection(
                              reviews: cubit.reviewsResponseModel?.reviews,
                            ),
                          ),
                        ],
                      ),
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
