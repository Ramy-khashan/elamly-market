import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_images.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {super.key,
      this.readOnly = false,
      this.controller,
      this.onTap,
      this.onChange});
  final bool readOnly;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(dynamic val)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChange,
      controller: controller,
      style: TextStyle(color: MyColors.blackColor),
      decoration: InputDecoration(
          prefixIcon: Image.asset(MyImages.searchIcon),
          hintText: 'Search Store',
          hintStyle: TextStyle(color: MyColors.greyColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide: BorderSide.none),
          fillColor: MyColors.searchBarColor,
          filled: true),
    );
  }
}
