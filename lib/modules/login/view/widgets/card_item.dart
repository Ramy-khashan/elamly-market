import 'package:flutter/material.dart';

import '../../../../core/utils/my_colors.dart';

class CardItem extends StatelessWidget {
  const CardItem(
      {super.key,
      required this.image,
      required this.title,
      required this.onPressed});
  final String image;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.all(1),
         height: (57),
         width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 2,
                color: Theme.of(context).brightness.index == 0
                    ? MyColors.whiteColor
                    : MyColors.searchBarColor),
            color: Theme.of(context).brightness.index == 0
                ? MyColors.searchBarColor
                : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: (25),
              height: (25),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
