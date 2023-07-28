import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'master_value_field.dart';

class MasterValueHour extends StatelessWidget {
  const MasterValueHour({
    super.key,
    this.restorationId,
    required this.controller,
    this.validations,
  });

  final String? restorationId;
  final MasterValueController<TimeOfDay> controller;
  final List<String? Function(TimeOfDay?)>? validations;

  String _hourToString(TimeOfDay hour) {
    return '${hour.hour.toString().padLeft(2, '0')}:${hour.minute.toString().padLeft(2, '0')} hrs';
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return MasterValueField<TimeOfDay>(
      validations: validations,
      label: i18n.hours,
      hintText: '--:-- hr',
      icon: TablerIcons.clock_play,
      controller: controller,
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: controller.value ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.input,
          cancelText: i18n.cancel,
          confirmText: i18n.accept,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    textStyle: const MaterialStatePropertyAll(
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    foregroundColor: MaterialStatePropertyAll(
                      const AppColors().accentColor25,
                    ),
                  ),
                ),
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: true,
                  ),
                  child: child!,
                ),
              ),
            );
          },
        );

        if (time != null) {
          controller.setValue(time);
        }
      },
      renderValue: (TimeOfDay? value) {
        return Text(
          value != null ? _hourToString(controller.value!) : '--:-- hr',
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
