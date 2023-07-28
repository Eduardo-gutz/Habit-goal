import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/button.dart';
import 'package:habit_goal/src/components/calendar/calendar.dart';
import 'package:habit_goal/src/components/calendar/calendar_days.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MasterValueController controller;

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late MarkDay? mark;
  late DateTime _dateSelected;

  void selectDate(DateTime date) {
    mark = MarkDay(
      date: date,
      color: const AppColors().success,
    );
    setState(() {
      _dateSelected = date;
      mark = mark;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller.value != null) {
      mark = MarkDay(
        date: widget.controller.value ?? DateTime.now(),
        color: const AppColors().success,
      );
    } else {
      mark = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Calendar(
            showToday: true,
            marks: mark != null ? [mark!] : null,
            onTapDay: selectDate,
            footer: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Button(
                    text: i18n.accept,
                    onPress: () {
                      widget.controller.setValue(_dateSelected);
                      Navigator.of(context).pop();
                    },
                  ),
                  Button(
                    text: i18n.cancel,
                    secondary: true,
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
