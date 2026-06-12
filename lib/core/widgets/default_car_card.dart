import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';

class DefaultCarCard extends StatelessWidget {
  final int index;
  final String imageUrl;
  final String brandName;
  final String model;
  final String year;
  final int seats;
  const DefaultCarCard({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.brandName,
    required this.model,
    required this.year,
    required this.seats
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: AppColors.background,
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
                  const Icon(Icons.error, color: Colors.red),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '$brandName $model $year',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(IconBroken.Star, color: AppColors.rating),
                        ),
                        Text('0.0')
                      ],
                    ),
                  
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.chair_sharp,color: AppColors.secondary,),

                    Text('$seats',style: Theme.of(context).textTheme
                    .titleMedium,)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
