import 'package:flutter/material.dart';
import 'package:quiz_app_riverpod/core/navigations/custom_navigation_helper.dart';
import 'package:quiz_app_riverpod/utils/theme/colors.dart';
import 'package:quiz_app_riverpod/utils/theme/textstyles.dart';

class SignUpAndLoginText extends StatelessWidget {
  final Widget navigationWidget;
  final bool isSignUn;
  const SignUpAndLoginText(
      {super.key, required this.navigationWidget, required this.isSignUn});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          pushReplacementPageAll(
              context: context, destination: navigationWidget);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            isSignUn
                ? "Already have an account? Please login"
                : "Don't have account? Please Sign up",
            style: textStyles14BBLUE.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: colorBlack,
              color: colorBlack,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
