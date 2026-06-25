import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';

class DefaultBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const DefaultBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onPressed ?? () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: isDark ? AppColors.background : AppColors.backgroundDark,
        ),
      ),
    );
  }
}
