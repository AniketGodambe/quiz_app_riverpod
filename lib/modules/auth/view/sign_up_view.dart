import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app_riverpod/core/navigations/custom_navigation_helper.dart';
import 'package:quiz_app_riverpod/modules/auth/view/login_view.dart';
import 'package:quiz_app_riverpod/modules/auth/view/widget/app_logo_name.dart';
import 'package:quiz_app_riverpod/modules/auth/view/widget/sign_up_and_login_text.dart';
import 'package:quiz_app_riverpod/modules/auth/view_models/sign_up_view_model.dart';
import 'package:quiz_app_riverpod/modules/dashboard/dashboard_view.dart';
import '../../../utils/custom_textfield.dart';
import '../../../utils/primary_button.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  var signupFormKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController dob = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    mobile.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (!signupFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    await ref
        .read(signUpViewModelProvider.notifier)
        .signUp(email.text, fullName.text, mobile.text, password.text, "");
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpViewModelProvider);

    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SignUp successful')),
        );

        fullName.clear();
        email.clear();
        mobile.clear();
        password.clear();

        pushReplacementPageAll(
            context: context, destination: const DashboardView());
      });
    }

    // Handle error state
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
              navigationWidget: LoginView(),
              isSignUn: false,
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              buttonName: "Login",
              onTap: state.isLoading ? null : signUp,
              isLoading: state.isLoading,
              isBottomBar: true,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: signupFormKey,
            child: Column(
              children: [
                const AppLogoName(),
                const SizedBox(height: 30),
                CustomTextfield(
                  lable: "Full Name",
                  hintText: "Enter here...",
                  controller: fullName,
                  isValidator: true,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  lable: "Email",
                  hintText: "Enter here...",
                  isValidator: true,
                  controller: email,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  lable: "Mobile",
                  hintText: "Enter here...",
                  controller: mobile,
                  isValidator: false,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _selectDate();
                  },
                  child: CustomTextfield(
                    lable: "Date Of Birth",
                    hintText: "Enter here...",
                    controller: dob,
                    isValidator: true,
                    isEnabled: false,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  lable: "Password",
                  hintText: "Enter here...",
                  controller: password,
                  isValidator: true,
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _selectDate() async {
    DateTime today = DateTime.now();
    DateTime sixYearsAgo = DateTime(today.year - 6, today.month, today.day);
    DateTime hundredYearsAgo =
        DateTime(today.year - 100, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sixYearsAgo,
      firstDate: hundredYearsAgo,
      lastDate: sixYearsAgo,
    );

    if (picked != null) {
      setState(() {
        dob.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
