import 'package:flutter/material.dart';
import 'package:quiz_app_riverpod/utils/theme/textstyles.dart';

import 'theme/colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? message;
  final String? title;
  final String yesText;
  final String noText;
  final bool showNoText;
  final Function()? noAction;
  final Function()? yesAction;

  const ConfirmationDialog(
      {super.key,
      this.message,
      this.yesText = 'yes',
      this.noText = 'no',
      this.yesAction,
      this.showNoText = true,
      this.title = 'Alert',
      this.noAction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title!,
                    style: textStyles18BBOLD,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Divider(
                    height: 1.0,
                    color: colorGrey,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: textStyles14BBOLD,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                if (showNoText)
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: noAction,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                          ),
                        ),
                        child: Text(
                          noText,
                          textAlign: TextAlign.center,
                          style: textStyles18BBOLD,
                        ),
                      ),
                    ),
                  ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: yesAction,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Text(
                        yesText,
                        textAlign: TextAlign.center,
                        style: textStyles18WBOLD,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
