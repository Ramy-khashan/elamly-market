import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

  
class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? const CircularProgressIndicator(
              color: MyColors.greenColor,
             )
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
