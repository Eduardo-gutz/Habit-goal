import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/calendar/calendar_days.dart';
import 'package:habit_goal/src/components/calendar/week_days.dart';
import 'package:habit_goal/src/components/calendar/header_calendar.dart';
import 'package:habit_goal/src/provider/locale_provider.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    this.marks,
    this.onTapDay,
    this.showToday = false,
    this.footer,
  }) : super(key: key);

  final List<MarkDay>? marks;
  final bool showToday;
  final void Function(DateTime)? onTapDay;
  final Widget? footer;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<MarkDay>? marks;
  final _appColors = const AppColors();
  late DateTime _date = DateTime.now();

  @override
  void initState() {
    marks = widget.marks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: _appColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          HeaderCalendar(
            locale: provider.locale,
            initDate: _date,
            onChange: (DateTime newDate) {
              setState(() {
                _date = newDate;
              });
            },
          ),
          WeekDays(
            locale: provider.locale,
          ),
          CalendarDays(
            showToday: widget.showToday,
            currentDate: _date,
            marks: widget.marks,
            onTapDay: widget.onTapDay,
          ),
          widget.footer ?? Container(),
        ],
      ),
    );
  }
}
