import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app_riverpod/core/navigations/custom_navigation_helper.dart';
import 'package:quiz_app_riverpod/modules/auth/view/widget/app_logo_name.dart';
import 'package:quiz_app_riverpod/modules/auth/view/widget/sign_up_and_login_text.dart';
import 'package:quiz_app_riverpod/modules/auth/view/sign_up_view.dart';
import 'package:quiz_app_riverpod/modules/auth/view_models/login_view_model.dart';
import 'package:quiz_app_riverpod/modules/dashboard/dashboard_view.dart';
import 'package:quiz_app_riverpod/utils/custom_textfield.dart';
import 'package:quiz_app_riverpod/utils/primary_button.dart';
import 'package:quiz_app_riverpod/utils/theme/colors.dart';
import 'package:quiz_app_riverpod/utils/theme/textstyles.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  Future<void> _login() async {
    final mobileOrEmail = ref.watch(loginWithEmail)
        ? ref.watch(emailProvider).text.trim()
        : ref.watch(mobileProvider).text.trim();
    final password = ref.watch(passwordProvider).text.trim();

    if (mobileOrEmail.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    await ref
        .read(loginViewModelProvider.notifier)
        .login(mobileOrEmail, password);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);
    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        ref.read(emailProvider).clear();
        ref.read(mobileProvider).clear();
        ref.read(passwordProvider).clear();
        pushReplacementPageAll(
            context: context, destination: const DashboardView());
      });
    }

    if (state.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error!)),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SignUpAndLoginText(
            navigationWidget: SignUpView(),
            isSignUn: false,
          ),
          const SizedBox(height: 10),
          PrimaryButton(
            buttonName: "Login",
            onTap: state.isLoading ? null : _login,
            isLoading: state.isLoading,
            isBottomBar: true,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AppLogoName(),
            const SizedBox(height: 50),
            if (ref.watch(loginWithEmail))
              CustomTextfield(
                controller: ref.watch(emailProvider),
                lable: "Email",
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter here...",
              )
            else
              CustomTextfield(
                controller: ref.watch(mobileProvider),
                lable: "Mobile",
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter here...",
              ),
            const SizedBox(height: 20),
            CustomTextfield(
              controller: ref.watch(passwordProvider),
              lable: "Password",
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter here...",
              obscureText: true,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                ref.read(loginWithEmail.notifier).state =
                    !ref.read(loginWithEmail.notifier).state;
              },
              child: Text(
                ref.watch(loginWithEmail)
                    ? 'Login with Email'
                    : 'Login with Mobile',
                style: textStyles14BBLUE.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: colorBlack,
                  color: colorBlack,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
