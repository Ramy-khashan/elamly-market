import 'package:flutter/material.dart';

import 'my_colors.dart';

LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      MyColors.orangeColor.withOpacity(.3),
      MyColors.orangeColor.withOpacity(.5),
      MyColors.orangeColor.withOpacity(.8),
      MyColors.greyColor.withOpacity(.8),
      MyColors.greyColor,
    ]);
