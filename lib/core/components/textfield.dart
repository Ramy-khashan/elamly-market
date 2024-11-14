import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/my_colors.dart';

class TextFieldItem extends StatelessWidget {
  final String lable;
  final TextEditingController controller;
  final int lines;
  final TextInputType textInputType;
  final bool isNeedBorder;
  final List<TextInputFormatter>? inputFormatters;
  final String valid;
  final String lan;
  const TextFieldItem(
      {Key? key,
      this.valid = "",
      this.lan = "en",
      required this.controller,
      required this.lable,
      this.lines = 1,
      this.isNeedBorder = true,
      this.inputFormatters,
      this.textInputType = TextInputType.multiline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return valid;
          }
          return null;
        },
        textAlign: lan == "ar" ? TextAlign.right : TextAlign.left,
        controller: controller,
        maxLines: lines,
        keyboardType: TextInputType.multiline,
        autofocus: true,
        cursorColor: MyColors.greenColor,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: lable,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            enabledBorder: isNeedBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColors.greyColor))
                : const OutlineInputBorder(borderSide: BorderSide.none),
            disabledBorder: isNeedBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColors.greyColor))
                : const OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: isNeedBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green))
                : const OutlineInputBorder(borderSide: BorderSide.none),
            border: isNeedBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColors.greyColor))
                : const OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
