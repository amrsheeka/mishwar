import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';

class BrandItem extends StatelessWidget {
  final int index;
  final String imageUrl;
  const BrandItem({super.key, required this.imageUrl, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
