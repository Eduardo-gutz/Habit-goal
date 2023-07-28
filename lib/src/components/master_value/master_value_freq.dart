import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:habit_goal/src/components/dialogs/frequency_dialog.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'master_value_field.dart';

class MasterValueFrequency extends StatelessWidget {
  const MasterValueFrequency({
    super.key,
    this.restorationId,
    required this.controller,
    this.validations,
  });

  final String? restorationId;
  final MasterValueController<String> controller;
  final List<String? Function(String?)>? validations;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return MasterValueField<String>(
      validations: validations,
      label: i18n.frequency,
      hintText: '------',
      icon: TablerIcons.two4_hours,
      controller: controller,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FrequencyDialog(
                controller: controller,
              );
            });
      },
      renderValue: (String? value) {
        return Text(
          value != null ? i18n.frequencyValues(controller.value!) : '------',
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
