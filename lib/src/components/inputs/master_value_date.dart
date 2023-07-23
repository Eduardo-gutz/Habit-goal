import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/button.dart';
import 'package:habit_goal/src/components/calendar/calendar.dart';
import 'package:habit_goal/src/components/calendar/calendar_days.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/provider/locale_provider.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class _MasterValueDate extends State<MasterValueDate> with RestorationMixin {
  late RestorableRouteFuture<DateTime> _dateRoute;
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
  String get restorationId => 'date_picker';

  @override
  void initState() {
    super.initState();
    _dateRoute = RestorableRouteFuture<DateTime>(
        onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _dateRouteBuilder,
        arguments: arguments,
      );
    }, onComplete: (DateTime? date) {
      widget.controller.setValue(date);
    });
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_dateRoute, 'route');
  }

  @override
  void dispose() {
    super.dispose();
    _dateRoute.dispose();
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _dateRouteBuilder(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return const CalendarDialog();
      },
    );
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
        _dateRoute.present();
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

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({Key? key}) : super(key: key);

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> with RestorationMixin {
  final RestorableDateTime _date = RestorableDateTime(DateTime.now());
  late MarkDay? mark;

  void selectDate(DateTime date) {
    _date.value = date;
    mark = MarkDay(
      date: date,
      color: const AppColors().primaryColor,
    );
    setState(() {
      mark = mark;
    });
  }

  @override
  String get restorationId => 'calendar';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_date, 'date');
  }

  @override
  void dispose() {
    super.dispose();
    _date.dispose();
  }

  @override
  void initState() {
    super.initState();
    mark = null;
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
                      Navigator.of(context).pop(_date.value);
                    },
                  ),
                  Button(
                    text: i18n.cancel,
                    secondary: true,
                    onPress: () {
                      Navigator.of(context).pop(null);
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
