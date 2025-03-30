import 'package:flutter/material.dart';

import 'theme/colors.dart';
import 'theme/textstyles.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final Color buttonColor;
  final Color buttonTextColor;

  final String buttonName;
  final bool isLoading;
  final bool isEnable;
  final bool isBottomBar;

  const PrimaryButton({
    super.key,
    this.onTap,
    this.buttonColor = colorBlack,
    this.buttonTextColor = colorWhite,
    required this.buttonName,
    this.isLoading = false,
    this.isBottomBar = false,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5),
          margin: !isBottomBar
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(4)),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: colorWhite,
                  )
                : Text(
                    buttonName,
                    style: textStyles16WBOLD.copyWith(color: buttonTextColor),
                    textAlign: TextAlign.center,
                  ),
          )),
    );
  }
}
