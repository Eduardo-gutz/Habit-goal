import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/dialogs/calendar_dialog.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/provider/locale_provider.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:provider/provider.dart';
import 'master_value_field.dart';

class MasterValueDate extends StatefulWidget {
  const MasterValueDate({
    super.key,
    this.restorationId,
    required this.label,
    this.icon = Icons.calendar_today_rounded,
    required this.controller,
    this.validations,
  });

  final String? restorationId;
  final String label;
  final IconData? icon;
  final MasterValueController<DateTime> controller;
  final List<String? Function(DateTime?)>? validations;

  @override
  State<MasterValueDate> createState() => _MasterValueDate();
}

class _MasterValueDate extends State<MasterValueDate> {
  List<String> shortMonthsEn = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<String> shortMonthsEs = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic'
  ];

  String _parceDate(DateTime date, String locale) {
    List<String> shortMonths = locale == 'en' ? shortMonthsEn : shortMonthsEs;
    return '${date.day < 10 ? '0${date.day}' : date.day}/${shortMonths[date.month - 1]}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return MasterValueField<DateTime>(
      validations: widget.validations,
      label: widget.label,
      hintText: 'DD/MM/YYYY',
      icon: widget.icon,
      controller: widget.controller,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CalendarDialog(
                controller: widget.controller,
              );
            });
      },
      renderValue: (DateTime? value) {
        return Text(
          value != null
              ? _parceDate(value, provider.locale.languageCode)
              : 'DD/MM/YYYY',
          style: TextStyle(
            color: const AppColors().accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        );
      },
    );
  }
}
