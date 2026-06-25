import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/utils/contants.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/features/car_details/views/car_details_view.dart';

class DefaultCarCard extends StatelessWidget {
  final int id;
  final int index;
  final String imageUrl;
  final String brandName;
  final String model;
  final String year;
  final int seats;
  final String fuelType;
  final String transmission;
  final double pricePerDay;
  final double reviewsAvgRating;
  const DefaultCarCard({
    super.key,
    required this.id,
    required this.index,
    required this.imageUrl,
    required this.brandName,
    required this.model,
    required this.year,
    required this.seats,
    required this.fuelType,
    required this.transmission,
    required this.pricePerDay,
    required this.reviewsAvgRating
  });


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        navigateTo(context: context, page: CarDetailsView(id: id));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark
              : AppColors.surface.withValues(alpha: 0.42),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 180,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: AppColors.grey.withValues(alpha: 0.18)),
                  errorWidget: (context, url, error) =>
                      Image.asset(defaultImage),
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '$brandName $model $year',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.rating.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.rating,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              reviewsAvgRating.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _CarMetaItem(
                        icon: Icons.chair_sharp,
                        label: '$seats',
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CarMetaItem(
                          icon: Icons.drive_eta_sharp,
                          label: transmission,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$$pricePerDay',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        ' /d',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarMetaItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CarMetaItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
