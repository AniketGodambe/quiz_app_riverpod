import 'package:flutter/material.dart';
import '../../../utils/custom_textfield.dart';
import '../../../utils/primary_button.dart';
import '../../../utils/theme/colors.dart';
import '../../../utils/theme/textstyles.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      bottomNavigationBar: PrimaryButton(
        onTap: () {},
        buttonColor: colorBlack,
        buttonName: "Sign Up",
        isLoading: false,
        isEnable: true,
        isBottomBar: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Quiz App",
              style:
                  textStyles16BBOLD.copyWith(fontSize: 30, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomTextfield(
              lable: "Full Name",
              hintText: "Enter here...",
              controller: fullName,
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              lable: "Email",
              hintText: "Enter here...",
              controller: email,
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              lable: "Mobile",
              hintText: "Enter here...",
              controller: mobile,
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              lable: "Password",
              hintText: "Enter here...",
              controller: password,
            ),
          ],
        ),
      ),
    );
  }
}
