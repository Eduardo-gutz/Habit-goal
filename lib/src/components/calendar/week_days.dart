import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({
    Key? key,
    this.locale = const Locale('en', 'EN'),
  }) : super(key: key);

  final Locale locale;

  final _appColors = const AppColors();
  static const List<String> daysEs = [
    'D',
    'L',
    'M',
    'M',
    'J',
    'V',
    'S',
  ];
  static const List<String> daysEn = [
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
  ];

  List<Widget> _buildDays() {
    final List<Widget> days = [];

    for (var i = 0; i < 7; i++) {
      days.add(
        Text(
          locale.languageCode == 'en' ? daysEn[i] : daysEs[i],
          style: TextStyle(
            color: _appColors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: EdgeInsets.fromLTRB(11, 4, 13, 4),
      decoration: BoxDecoration(
        color: _appColors.primaryColor.withOpacity(.11),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildDays(),
      ),
    );
  }
}
