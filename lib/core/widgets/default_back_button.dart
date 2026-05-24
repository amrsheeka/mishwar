import 'package:flutter/material.dart';

class DefaultBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const DefaultBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onPressed ?? () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
