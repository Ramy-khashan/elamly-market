import 'package:flutter/material.dart';

import 'my_colors.dart';

LinearGradient linearGradient=LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        MyColors.greenColor.withOpacity(.3),
                                        MyColors.greenColor.withOpacity(.5),
                                        MyColors.greenColor.withOpacity(.8),
                                        MyColors.greyColor.withOpacity(.8),
                                        MyColors.greyColor,
                                      ]);