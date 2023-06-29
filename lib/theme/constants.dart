import 'package:flutter/material.dart';
import 'package:habit_goal/theme/colors.dart';

const appColors = AppColors();

ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: appColors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0.0),
      minimumSize: MaterialStateProperty.all<Size>(const Size(200, 40)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )),
      backgroundColor:
          MaterialStateProperty.all<Color>(appColors.secondaryColor),
    )));
