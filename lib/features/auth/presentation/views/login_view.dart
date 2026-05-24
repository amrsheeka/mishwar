import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/widgets/default_button.dart';
import 'package:mishwar/core/widgets/default_text_field.dart';
import 'package:mishwar/features/auth/presentation/views/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool hidePassword = true;
  IconData suffexIcon = Icons.visibility_off;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 50),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          'Sign in',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: AlignmentGeometry.centerStart,
                        child: Text(
                          'Please sign in to continue',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                DefaultTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "email",
                ),
                const SizedBox(height: 20),
                DefaultTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: hidePassword,
                  labelText: "password",
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
                SizedBox(height: 10),
                Align(
                  alignment: AlignmentGeometry.centerEnd,
                  child: InkWell(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DefaultButton(onPressed: () {}, text: "Sign in"),
                SizedBox(height: 30),
                DefaultButton(
                  backgroundColor: isDark
                      ? AppColors.grey
                      : AppColors.surfaceDark,
                  text: "Sign in with Google",
                  onPressed: () {},
                  prefexIcon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not registered? ",
                      style: TextStyle(color: AppColors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(
                          context: context,
                          page: SignUpView(),
                          type: PageTransitionType.fade,
                        );
                      },
                      child: Text("Create an account"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
