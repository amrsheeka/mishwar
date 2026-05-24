import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/widgets/default_back_button.dart';
import 'package:mishwar/core/widgets/default_button.dart';
import 'package:mishwar/core/widgets/default_text_field.dart';
import 'package:mishwar/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:mishwar/features/auth/presentation/views/login_view.dart';

class ConfirmEmailView extends StatefulWidget {
  const ConfirmEmailView({super.key, required this.email});

  final String email;

  @override
  State<ConfirmEmailView> createState() => _ConfirmEmailViewState();
}

class _ConfirmEmailViewState extends State<ConfirmEmailView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void _submitConfirmation(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().confirmEmail(
      email: widget.email,
      code: codeController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is EmailConfirmationSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email confirmed successfully. Please sign in.'),
              ),
            );
            navigateAndFinish(
              context: context,
              page: const LoginView(),
              type: PageTransitionType.fade,
            );
          }

          if (state is EmailConfirmationErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is EmailConfirmationLoadingState;

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
                      child: Form(
                        key: _formKey,
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
                              'Confirm Your Email',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'We sent a 6-digit code to your email.\nPlease enter it below to verify your account.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 40),
                            DefaultTextField(
                              controller: codeController,
                              keyboardType: TextInputType.number,
                              labelText: 'verification code',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter the verification code';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 40),
                            DefaultButton(
                              text: 'Verify Email',
                              isLoading: isLoading,
                              onPressed: isLoading
                                  ? null
                                  : () => _submitConfirmation(context),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'A new code has been requested.',
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Resend Code'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
