import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/calendar/icon_pressable.dart';

import '../../theme/colors.dart';

class HeaderCalendar extends StatefulWidget {
  const HeaderCalendar({
    Key? key,
    this.initDate,
    this.locale = const Locale('en', 'EN'),
    this.onChange,
  }) : super(key: key);

  final DateTime? initDate;
  final Locale? locale;
  final void Function(DateTime)? onChange;

  @override
  _HeaderCalendarState createState() => _HeaderCalendarState();
}

class _HeaderCalendarState extends State<HeaderCalendar> {
  final _appColors = const AppColors();
  late DateTime _date;
  int currentMonth = 1;
  int currentYear = 1999;
  late List<String> months = [];

  static const List<String> _monthsEs = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  static const List<String> _monthsEn = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void changeDate() {
    if (widget.onChange != null) {
      widget.onChange!(_date);
    }
  }

  void changeToNextMonth() {
    var month = 1;
    var year = currentYear;

    if (currentMonth < 12) {
      month = currentMonth + 1;
    } else {
      year = currentYear + 1;
    }

    setState(() {
      _date = DateTime(year, month, _date.day);
      currentMonth = month;
      currentYear = year;
    });
    changeDate();
  }

  void changeToPrevMonth() {
    var month = 12;
    var year = currentYear;

    if (currentMonth > 1) {
      month = currentMonth - 1;
    } else {
      year = currentYear - 1;
    }

    setState(() {
      _date = DateTime(year, month, _date.day);
      currentMonth = month;
      currentYear = year;
    });
    changeDate();
  }

  @override
  void initState() {
    _date = widget.initDate ?? DateTime.now();
    currentMonth = _date.month;
    currentYear = _date.year;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    months = widget.locale?.languageCode == 'es' ? _monthsEs : _monthsEn;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconPressable(
          icon: Icons.arrow_back_ios_new,
          onPress: changeToPrevMonth,
        ),
        Column(
          children: [
            Text(
              months[currentMonth - 1],
              style: TextStyle(
                color: _appColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentYear.toString(),
              style: TextStyle(
                color: _appColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        IconPressable(
          icon: Icons.arrow_forward_ios,
          onPress: changeToNextMonth,
        ),
      ],
    );
  }
}
