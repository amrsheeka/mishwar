import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/utils/toast.dart';
import 'package:mishwar/core/widgets/default_button.dart';
import 'package:mishwar/core/widgets/default_text_field.dart';
import 'package:mishwar/core/widgets/responsive_content.dart';
import 'package:mishwar/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:mishwar/features/auth/presentation/views/confirm_email_view.dart';
import 'package:mishwar/features/auth/presentation/views/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  IconData suffexIcon = Icons.visibility_off;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitSignUp(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().signUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            navigateTo(
              context: context,
              page: ConfirmEmailView(email: emailController.text.trim()),
              type: PageTransitionType.fade,
            );
            showToast(
              message: 'Account created. Confirm your email.',
              type: ToastType.SUCCESS,
            );
          }

          if (state is SignupErrorState) {
            showToast(message: state.message, type: ToastType.ERROR);
          }
        },
        builder: (context, state) {
          final isLoading = state is SignupLoadingState;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ResponsiveContent(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 28),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1_rounded,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please sign up to continue',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 30),
                        DefaultTextField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          labelText: 'Name',
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.grey,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        DefaultTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.grey,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        DefaultTextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePassword,
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.grey,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (hidePassword) {
                                  suffexIcon = Icons.visibility_off;
                                  hidePassword = false;
                                } else {
                                  suffexIcon = Icons.visibility;
                                  hidePassword = true;
                                }
                              });
                            },
                            child: Icon(suffexIcon, color: AppColors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DefaultTextField(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePassword,
                          labelText: 'Confirm password',
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.grey,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (hidePassword) {
                                  suffexIcon = Icons.visibility_off;
                                  hidePassword = false;
                                } else {
                                  suffexIcon = Icons.visibility;
                                  hidePassword = true;
                                }
                              });
                            },
                            child: Icon(suffexIcon, color: AppColors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                          text: 'Sign up',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () => _submitSignUp(context),
                        ),
                        const SizedBox(height: 30),
                        DefaultButton(
                          backgroundColor: isDark
                              ? AppColors.surfaceDark
                              : AppColors.surfaceDark,
                          textColor: AppColors.background,
                          text: 'Sign in with Google',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Google sign-up is not implemented.',
                                ),
                              ),
                            );
                          },
                          prefexIcon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: AppColors.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already registered? '),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  page: const LoginView(),
                                  type: PageTransitionType.fade,
                                );
                              },
                              child: const Text('Sign in'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
