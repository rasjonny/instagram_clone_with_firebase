import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/auth_state_providers.dart';
import 'package:instagram_clone_with_firebase/views/constants/app_colors.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/login/dividers_with_margin.dart';
import 'package:instagram_clone_with_firebase/views/login/facebook_login_button.dart';
import 'package:instagram_clone_with_firebase/views/login/google_login_button.dart';
import 'package:instagram_clone_with_firebase/views/login/login_signup_link.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('LoginView')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargin(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: AppColors.loginButtonTextColor,
                      backgroundColor: AppColors.loginButtonColor),
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithGoogle,
                  child: const GoogleLoginButton()),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: AppColors.loginButtonTextColor,
                      backgroundColor: AppColors.loginButtonColor),
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithGoogle,
                  child: const FacebookLoginButton(),),
                  const DividerWithMargin(),
                  const LoginSignupLink(),
            ],
          ),
        ),
      ),
    );
  }
}
