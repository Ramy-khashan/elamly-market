import 'package:flutter/material.dart';

class HelpModel {
  final String title;
  final IconData leading;
  final String subTitle;
  final Function() onTap;

  HelpModel(
      {required this.title,
      required this.onTap,
      required this.leading,
      required this.subTitle});
}
