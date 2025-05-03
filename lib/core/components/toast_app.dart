import 'package:elamlymarket/core/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastApp({required String message,bool isError=false}) => Fluttertoast.showToast(
      msg: message,
      backgroundColor:isError? Colors.red:MyColors.orangeColor
    );
