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
  });


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        navigateTo(context: context, page: CarDetailsView(id: id,));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: isDark?AppColors.surfaceDark: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: AppColors.grey.withValues(alpha: 0.3)),
                errorWidget: (context, url, error) =>
                    Image.asset(defaultImage),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '$brandName $model $year',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(IconBroken.Star, color: AppColors.rating),
                            ),
                            Text('0.0'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.chair_sharp, color: AppColors.secondary),
      
                      Text(
                        '$seats',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Icon(Icons.propane_tank_sharp, color: AppColors.secondary),
      
                      Text(
                        fuelType,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Icon(Icons.drive_eta_sharp, color: AppColors.secondary),
      
                      Text(
                        transmission,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        '\$',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.green),
                      ),
      
                      Text(
                        '$pricePerDay',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '/d',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.grey),
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
