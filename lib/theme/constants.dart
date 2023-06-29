import 'package:flutter/material.dart';
import 'package:habit_goal/theme/colors.dart';

const appColors = AppColors();

ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: appColors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            foregroundColor: MaterialStatePropertyAll(appColors.accentColor),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.fromLTRB(4, 0, 4, 0)))),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: appColors.black,
      ),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: appColors.primaryColor),
    ),
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
