import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:habit_goal/src/components/dialogs/frequency_dialog.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'master_value_field.dart';

class MasterValueBoolean extends StatefulWidget {
  const MasterValueBoolean({
    super.key,
    required this.label,
    required this.controller,
    this.validations,
  });

  final String label;
  final MasterValueController<bool> controller;
  final List<String? Function(bool?)>? validations;

  @override
  State<MasterValueBoolean> createState() => _MasterValueBooleanState();
}

class _MasterValueBooleanState extends State<MasterValueBoolean> {
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.value = widget.controller.value ?? false;
    _controller.addListener(() {
      widget.controller.value = _controller.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return MasterValueField<bool>(
      validations: widget.validations,
      label: widget.label,
      icon: TablerIcons.bell,
      controller: widget.controller,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FrequencyDialog(
                controller: widget.controller,
              );
            });
      },
      renderValue: (bool? value) {
        return AdvancedSwitch(
          controller: _controller,
          height: 24,
          width: 54,
          activeColor: AppColors().accentColor,
          inactiveColor: AppColors().accentColor,
          thumb: Container(
            decoration: BoxDecoration(
              color: AppColors().secondaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          activeChild: Text(
            'Si',
          ),
          inactiveChild: Text(
            'No',
          ),
        );
      },
    );
  }
}
