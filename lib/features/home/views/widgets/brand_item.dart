import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/features/search/cubits/search/search_cubit.dart';
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
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final params = CarSearchParams(
          brandId: id,
        );
        navigateTo(
          context: context,
          page: BlocProvider(
            create: (context) => SearchCubit()..search(params),
            child: SearchResultsView(params: params),
          ),
        );
      },
      child: Container(
        width: 68,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark
              : AppColors.surface.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.10),
          ),
        ),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                Container(color: AppColors.grey.withValues(alpha: 0.18)),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline_rounded, color: AppColors.error),
          ),
        ),
      ),
    );
  }
}
