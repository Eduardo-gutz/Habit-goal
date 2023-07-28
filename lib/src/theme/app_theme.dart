import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:habit_goal/src/theme/constants.dart';

const appColors = AppColors();

ThemeData mainTheme = ThemeData(
  scaffoldBackgroundColor: appColors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  textButtonTheme: textButtonTheme,
  textTheme: textTheme,
  floatingActionButtonTheme: floatingActionButtonTheme,
  elevatedButtonTheme: elevatedButtonThemeData,
  timePickerTheme: timePikerThemeData,
);
