import 'package:flutter/material.dart';
import 'package:quiz_app_riverpod/utils/theme/textstyles.dart';

class AppLogoName extends StatelessWidget {
  const AppLogoName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Quiz App",
      style: textStyles16BBOLD.copyWith(fontSize: 30, letterSpacing: 2.0),
      textAlign: TextAlign.center,
    );
  }
}
