import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/button.dart';
import 'package:habit_goal/src/components/card/card.dart';
import 'package:habit_goal/src/components/inputs/check_option.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FrequencyDialog extends StatefulWidget {
  const FrequencyDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MasterValueController controller;

  @override
  State<FrequencyDialog> createState() => _FrequencyDialogState();
}

class _FrequencyDialogState extends State<FrequencyDialog> {
  List<String> periods = [
    'D', // Daily
    'DD', // Every 2 days
    'DDD', // Every 3 days
    'W', // Weekly
    'WW', // Every 2 weeks
    'M', // Monthly
    'S', // Sporadic
    'U', // Unique
    // 'C', // Custom
  ];

  final MasterValueController<String> controller =
      MasterValueController<String>();

  List<Widget> _buildDays(AppLocalizations lang) {
    final List<Widget> days = [];

    for (var i = 0; i < periods.length; i++) {
      days.add(
        CheckOption(
          label: lang.frequencyValues(periods[i]),
          value: periods[i],
          controller: controller,
        ),
      );
    }

    return days;
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
          child: Wrap(
            runSpacing: 4.0,
            children: [
              Text(
                i18n.frequency,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              ..._buildDays(i18n),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Button(
                      text: i18n.accept,
                      onPress: () {
                        widget.controller.setValue(controller.value);
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
            ],
          ),
        ),
      ],
    );
  }
}
