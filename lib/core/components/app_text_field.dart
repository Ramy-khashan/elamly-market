import 'package:flutter/material.dart';
import '../utils/my_colors.dart';
import 'text_gradient.dart';

class AppTextField extends StatelessWidget {
  final Function(dynamic value) onValidate;
  final Function(dynamic value)? onChange;
  final TextEditingController? controller;
  final String? label;
  final double? horizontal;
  final int? maxLines;
  final Widget? prefexIcon;
  final Function()? onPressShow;
  final bool isPassword;
  final bool isHidePassword;
  final TextInputType? keyboardType;
  const AppTextField(
      {super.key,
      required this.onValidate,
      this.controller,
      this.label,
      this.horizontal = 17,
      this.prefexIcon,
      this.onPressShow,
      this.maxLines=1,
      this.onChange,
      this.isPassword = false,
      this.isHidePassword = false,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7, left: horizontal!, right: horizontal!),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        onChanged: onChange,
        maxLines: maxLines,
        obscureText: isPassword ? isHidePassword : false,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => onValidate(value),
        style: const TextStyle(
            fontSize: 15, fontFamily: "mainFont", color: Colors.black),
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: prefexIcon,
          suffixIcon: isPassword
              ? GradientText(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        MyColors.greenColor,
                        MyColors.greenColor,
                        MyColors.greenColor,
                        MyColors.greyColor,
                        MyColors.greyColor,
                      ]),
                  child: IconButton(
                      onPressed: onPressShow,
                      icon: Icon(
                        isHidePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      )))
              : const SizedBox.shrink(),
          filled: true,
          hintText: label,
          hintStyle: TextStyle(
              fontSize: 15, color: MyColors.greyColor, fontFamily: "mainFont"),
          fillColor: Theme.of(context).brightness.index == 0
              ? MyColors.searchBarColor
              : const Color.fromARGB(255, 255, 255, 255),
          errorStyle: TextStyle(color: Colors.red.shade700),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red.shade700)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red.shade700)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                // color: Theme.of(context).brightness.index == 0
                //     ? AppColors.textFieldBorderDarkColor
                //     : AppColors.textFieldBorderColor,
                width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1.5),
          ),
        ),
      ),
    );
  }
}
