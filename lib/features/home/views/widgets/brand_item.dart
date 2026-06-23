import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/features/search/data/models/car_search_params.dart';
import 'package:mishwar/features/search/views/search_results_view.dart';

class BrandItem extends StatelessWidget {
  final int index;
  final int id;
  final String imageUrl;
  const BrandItem({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        navigateTo(
          context: context,
          page: SearchResultsView(params: CarSearchParams(
            brandId: id
          )),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                Container(color: AppColors.grey.withValues(alpha: 0.3)),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
