import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';

class Day extends StatefulWidget {
  const Day({
    Key? key,
    required this.date,
    this.disabled = false,
    this.selected = false,
    this.selectedColor,
    this.onTap,
  }) : super(key: key);

  final DateTime date;
  final bool disabled;
  final bool selected;
  final Color? selectedColor;
  final void Function(DateTime)? onTap;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  final _appColors = const AppColors();

  void handleTap() {
    if (widget.onTap != null) {
      widget.onTap!(widget.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = widget.selectedColor ?? _appColors.primaryColor;

    return GestureDetector(
      onTap: handleTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: selectedColor.withOpacity(widget.selected ? .2 : 0),
          border: widget.selected
              ? Border.all(
                  color: selectedColor,
                  width: 3.5,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            style: TextStyle(
              color: _appColors.white.withOpacity(widget.disabled ? .5 : 1),
              fontWeight: widget.disabled ? FontWeight.w300 : FontWeight.w400,
            ),
            widget.date.day.toString(),
          ),
        ),
      ),
    );
  }
}
