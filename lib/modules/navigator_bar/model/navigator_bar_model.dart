import 'package:flutter/material.dart';

class NavigatorBarModel {
  final String title;
  final IconData icon;
  final Widget? page;

  NavigatorBarModel(
      {required this.page, required this.title, required this.icon});
}
