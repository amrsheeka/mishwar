import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:see_more/see_more.dart';

Widget descriptionCard(BuildContext context, String description) {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isDark
          ? AppColors.surfaceDark
          : AppColors.surface.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notes_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Description",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DefaultTextStyle.merge(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.45),
          child: SeeMoreWidget(
            description != '' ? description : 'No Description',
            trimMode: TrimMode.line,
            maxLines: 3,
          ),
        ),
      ],
    ),
  );
}
