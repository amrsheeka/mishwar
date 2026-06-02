import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/widgets/default_button.dart';
import 'package:mishwar/core/widgets/default_text_field.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created. Confirm your email.'),
              ),
            );
          }

          if (state is SignupErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is SignupLoadingState;

          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sign up',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Please sign up to continue',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppColors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        DefaultTextField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          labelText: 'name',
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
                          labelText: 'email',
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
                          labelText: 'password',
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
                            child: Icon(suffexIcon),
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
                          ),
                        ),
                        const SizedBox(height: 20),
                        DefaultTextField(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePassword,
                          labelText: 'confirm password',
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
                            child: Icon(suffexIcon),
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
                          ),
                        ),
                        const SizedBox(height: 10),
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
                              ? AppColors.grey
                              : AppColors.surfaceDark,
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
                            color: Colors.red,
                          ),
                        ),
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
