import 'package:flutter/material.dart';
import 'package:quiz_app_riverpod/utils/custom_textfield.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: emailController,
      lable: "Email",
      keyboardType: TextInputType.emailAddress,
      hintText: "Enter here...",
      validator: validateEmail,
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    // Email validation regex
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null; // Validation passed
  }
}
