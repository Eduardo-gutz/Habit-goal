import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/calendar/calendar_days.dart';
import 'package:habit_goal/src/components/card/card.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/provider/locale_provider.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'master_value_field.dart';

class MasterValueFrequency extends StatefulWidget {
  const MasterValueFrequency({
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
  final MasterValueController<String> controller;
  final List<String? Function(String?)>? validations;

  @override
  State<MasterValueFrequency> createState() => _MasterValueFrequency();
}

class _MasterValueFrequency extends State<MasterValueFrequency>
    with RestorationMixin {
  late RestorableRouteFuture<String> _dateRoute;
  List<String> periods = [
    'D', // Daily
    'DD', // Every 2 days
    'DDD', // Every 3 days
    'W', // Weekly
    'WW', // Every 2 weeks
    'M', // Monthly
    'S', // Sporadic
    'U', // Unique
    'C', // Custom
  ];

  // String _parceDate(DateTime date, String locale) {
  //   List<String> shortMonths = locale == 'en' ? shortMonthsEn : shortMonthsEs;
  //   return '${date.day < 10 ? '0${date.day}' : date.day}/${shortMonths[date.month - 1]}/${date.year}';
  // }

  @override
  String get restorationId => 'date_picker';

  @override
  void initState() {
    super.initState();
    _dateRoute = RestorableRouteFuture<String>(
        onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _dateRouteBuilder,
        arguments: arguments,
      );
    }, onComplete: (String? date) {
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
  static Route<String> _dateRouteBuilder(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<String>(
      context: context,
      builder: (BuildContext context) {
        return const FrequencyDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final i18n = AppLocalizations.of(context)!;

    return MasterValueField<String>(
      validations: widget.validations,
      label: widget.label,
      hintText: '------',
      icon: widget.icon,
      controller: widget.controller,
      onTap: () {
        _dateRoute.present();
      },
      renderValue: (String? value) {
        return Text(
          value != null
              ? i18n.frequencyValues(widget.controller.value!)
              : '------',
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

class FrequencyDialog extends StatefulWidget {
  const FrequencyDialog({Key? key}) : super(key: key);

  @override
  State<FrequencyDialog> createState() => _FrequencyDialogState();
}

class _FrequencyDialogState extends State<FrequencyDialog>
    with RestorationMixin {
  final _appColors = const AppColors();
  List<String> periods = [
    'D', // Daily
    'DD', // Every 2 days
    'DDD', // Every 3 days
    'W', // Weekly
    'WW', // Every 2 weeks
    'M', // Monthly
    'S', // Sporadic
    'U', // Unique
    'C', // Custom
  ];
  final RestorableString _date = RestorableString('');
  late MarkDay? mark;

  @override
  String get restorationId => 'calendar';

  List<Widget> _buildDays(AppLocalizations lang) {
    final List<Widget> days = [];

    for (var i = 0; i < periods.length; i++) {
      days.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lang.frequencyValues(periods[i]),
              style: TextStyle(
                color: _appColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Checkbox(
              activeColor: _appColors.success,
              shape: OutlinedBorder.lerp(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                1,
              ),
              side: BorderSide(
                color: _appColors.secondaryColor,
                style: BorderStyle.solid,
                width: 3,
                strokeAlign: .5,
              ),
              value: true,
              onChanged: (bool? value) {
                print(value);
              },
            )
          ],
        ),
      );
    }

    return days;
  }

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardHG(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frecuencia',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              ..._buildDays(i18n),
            ],
          ),
        ),
      ],
    );
  }
}
