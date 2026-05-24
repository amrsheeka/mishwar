import 'package:flutter/material.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/widgets/default_back_button.dart';
import 'package:mishwar/core/widgets/default_button.dart';

class ConfirmEmailView extends StatelessWidget {
  const ConfirmEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultBackButton(),

              const SizedBox(height: 30),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mark_email_read_outlined,
                      size: 90,
                      color: AppColors.grey,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Confirm Your Email",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "We sent a 6-digit code to your email.\nPlease enter it below to verify your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.grey, fontSize: 14),
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 45,
                          height: 55,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.grey.shade900
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 40),

                    DefaultButton(text: "Verify Email", onPressed: () {}),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {},
                      child: const Text("Resend Code"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
