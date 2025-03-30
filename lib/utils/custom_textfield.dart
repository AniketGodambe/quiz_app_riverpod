import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_riverpod/utils/theme/colors.dart';

import 'theme/textstyles.dart';

class CustomTextfield extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;
  final String hintText;
  final List<TextInputFormatter> inputformate;
  final int maxLength;
  final bool showTextFieldLable;
  final Color fieldBgColor;
  final bool isEnabled;
  final bool isReadOnly;
  final Widget? prefixIcon;
  final BoxDecoration? containerDecoration;
  final EdgeInsets? containerPadding;
  final Function()? ontap;
  final Function()? onEditingC;
  final Function(String)? cOnChanged;

  final bool isSuffixIcon;
  final bool isLocationField;
  final bool isValidator;
  final bool filled;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextfield({
    super.key,
    this.lable = '',
    required this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintText = '',
    this.showTextFieldLable = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.fieldBgColor = colorWhite,
    this.maxLength = 100,
    this.inputformate = const [],
    this.keyboardType = TextInputType.name,
    this.prefixIcon,
    this.containerDecoration,
    this.containerPadding,
    this.ontap,
    this.onEditingC,
    this.cOnChanged,
    this.isSuffixIcon = false,
    this.isLocationField = false,
    this.isValidator = false,
    this.filled = false,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable.isNotEmpty) Text(lable, style: textStyles16BBOLD),
        if (lable.isNotEmpty) const SizedBox(height: 10),
        TextFormField(
          onTap: ontap,
          minLines: minLines,
          maxLines: maxLines,
          onEditingComplete: onEditingC,
          obscureText: obscureText,
          onChanged: (value) {
            cOnChanged!(value);
            if (isValidator) {
              Form.of(context).validate();
            }
          },
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          buildCounter: null,
          enabled: isEnabled,
          readOnly: isReadOnly,
          validator: validator,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          inputFormatters: inputformate,
          style: textStyles14BBOLD,
          decoration: InputDecoration(
            filled: filled,
            fillColor: fieldBgColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            hintText: hintText,
            hintStyle: textStyles16GBOLD.copyWith(fontWeight: FontWeight.w400),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorGrey.withOpacity(0.7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorGrey.withOpacity(0.7),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorGrey.withOpacity(0.7),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: colorRed,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: colorRed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
