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
    this.textColor = Colors.white,
    this.isLoading = false,
    this.prefexIcon,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: height,
            width: double.maxFinite,
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            height: height,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: InkWell(
                onTap: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefexIcon != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: prefexIcon,
                          )
                        : Container(),
                    Text(
                      text,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
