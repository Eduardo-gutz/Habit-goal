import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';

const appColors = AppColors();

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    foregroundColor: MaterialStatePropertyAll(appColors.accentColor),
    visualDensity: const VisualDensity(
      horizontal: 0,
      vertical: -4,
    ),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: const MaterialStatePropertyAll<EdgeInsets>(
      EdgeInsets.fromLTRB(4, 0, 4, 0),
    ),
  ),
);

final TextTheme textTheme = TextTheme(
  labelSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: appColors.black,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: appColors.primaryColor,
  ),
  bodyLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: appColors.black,
  ),
);

final FloatingActionButtonThemeData floatingActionButtonTheme =
    FloatingActionButtonThemeData(
  backgroundColor: appColors.secondaryColor,
  foregroundColor: appColors.black,
  iconSize: 48.0,
  largeSizeConstraints: const BoxConstraints.tightFor(
    width: 60.0,
    height: 6.0,
  ),
  sizeConstraints: const BoxConstraints.tightFor(
    width: 60.0,
    height: 60.0,
  ),
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100.0),
  ),
);

final ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0.0),
    minimumSize: MaterialStateProperty.all<Size>(const Size(200, 40)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )),
    backgroundColor: MaterialStateProperty.all<Color>(appColors.secondaryColor),
  ),
);
