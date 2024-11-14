import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.buttonChild,
      this.buttonText,
      this.isIcon = false,
      required this.onPressed,
      this.width,
      this.btnColorWhite = false, this.textColor});
  final Widget? buttonChild;
  final String? buttonText;
  final Color? textColor;
  final bool? isIcon;
  final bool? btnColorWhite;
  final double? width;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(isIcon! ? 30 : 15),
      splashColor: Colors.grey,
      hoverColor: Colors.white,
      
      highlightColor: Colors.grey.shade300,
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.all(1),
        width: width,
        padding: isIcon!
            ? const EdgeInsets.all(18)
            : const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isIcon! ? 50 : 15),
            gradient: LinearGradient(
                colors: btnColorWhite!
                    ? [
                        Colors.white,
                        Colors.white,
                      ]
                    : [MyColors.greenColor, MyColors.greyColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: buttonChild ??
            Text(
              buttonText ?? "",
              textAlign: TextAlign.center,
              style:   TextStyle(
                fontSize: 18,
                color: textColor??Colors.white,
                fontFamily: "mainFont",
                fontWeight: FontWeight.w800,
              ),
            ),
      ),
    );
  }
}
