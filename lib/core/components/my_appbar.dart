import 'package:flutter/material.dart';
 import '../utils/my_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final bool showTitle;
  final bool showActions;
  final String title;
  final String? image;
  const MyAppBar(
      {super.key,
      this.showLeading =false,
      this.showTitle =true,
      this.showActions=false,
      this.title="",
      this.image});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLeading
          ? IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios,
                color: MyColors.blackColor,
              ))
          : null,
      centerTitle: true,
      title: showTitle
          ? Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.blackColor),
            )
          : null,
      actions: showActions
          ? [IconButton(onPressed: () {}, icon: Image.asset(image!))]
          : [],
    );
  }
  
  @override
  Size get preferredSize => throw UnimplementedError();
}
