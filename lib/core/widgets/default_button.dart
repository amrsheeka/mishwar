import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final Icon? prefexIcon;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.maxFinite,
    this.height = 55,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.background,
    this.isLoading = false,
    this.prefexIcon,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: height,
            width: width,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          )
        : SizedBox(
            height: height,
            width: width,
            child: Material(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onPressed,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prefexIcon != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: prefexIcon,
                        ),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
