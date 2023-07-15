import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/calendar/day.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:collection/collection.dart';

class MarkDay {
  MarkDay({
    required this.date,
    this.color,
  });

  final DateTime date;
  final Color? color;
}

class CalendarDays extends StatefulWidget {
  const CalendarDays({
    Key? key,
    this.marks,
    this.showToday = false,
    this.disabledDays,
    this.onTapDay,
    this.currentDate,
  }) : super(key: key);

  final List<MarkDay>? marks;
  final bool showToday;
  final List<DateTime>? disabledDays;
  final void Function(DateTime)? onTapDay;
  final DateTime? currentDate;

  @override
  State<CalendarDays> createState() => _CalendarDaysState();
}

class _CalendarDaysState extends State<CalendarDays> {
  final _appColors = const AppColors();
  late DateTime _date;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime today;

  Widget handleDay(DateTime date) {
    final disabled = widget.disabledDays?.firstWhereOrNull(
      (DateTime element) => element == date,
    );
    final mark = widget.marks?.firstWhereOrNull(
      (element) => element.date == date,
    );

    final markToday = widget.showToday && date == today
        ? MarkDay(date: date, color: _appColors.secondaryColor)
        : null;

    final disabledThisDay = disabled != null || date.month != _date.month;
    final markThisDay = mark ?? markToday;

    return Day(
      date: date,
      disabled: disabledThisDay,
      selected: markThisDay != null,
      selectedColor: markThisDay?.color,
      onTap: widget.onTapDay,
    );
  }

  List<Widget> _buildColumnsDays() {
    final columns = List.generate(7, (i) {
      final column = List.generate(
        (_lastDay.difference(_firstDay).inDays / 7).ceil(),
        (j) {
          final day = _firstDay.add(Duration(days: i + j * 7));
          return handleDay(day);
        },
      );
      return Column(children: column);
    });
    return columns;
  }

  @override
  void initState() {
    final _today = DateTime.now();
    today = DateTime(_today.year, _today.month, _today.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _date = widget.currentDate ?? DateTime.now();
      final firstDay = DateTime(_date.year, _date.month, 1);
      final lastDay = DateTime(_date.year, _date.month + 1, 0);

      _firstDay = firstDay.subtract(Duration(days: firstDay.weekday));
      _lastDay = lastDay.add(Duration(days: 6 - lastDay.weekday));
    });
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildColumnsDays(),
      ),
    );
  }
}
