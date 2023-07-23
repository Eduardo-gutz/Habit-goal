import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_goal/src/components/button.dart';
import 'package:habit_goal/src/components/calendar/calendar.dart';
import 'package:habit_goal/src/components/inputs/master_value_date.dart';
import 'package:habit_goal/src/components/inputs/master_value_field.dart';
import 'package:habit_goal/src/components/inputs/input_field.dart';
import 'package:habit_goal/src/components/inputs/master_value_freq.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/helpers/forms/validation_mixin.dart';
import 'package:habit_goal/src/theme/colors.dart';

class NewHabitScreen extends StatefulWidget {
  const NewHabitScreen({Key? key}) : super(key: key);

  @override
  State<NewHabitScreen> createState() => _NewHabitScreen();
}

class _NewHabitScreen extends State<NewHabitScreen> with ValidationMixin {
  final TextEditingController _emailController = TextEditingController();
  final MasterValueController<DateTime> _startDateController =
      MasterValueController<DateTime>();
  final MasterValueController<DateTime> _endDateController =
      MasterValueController<DateTime>();
  final MasterValueController<String> _frequencyController =
      MasterValueController<String>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final RestorableRouteFuture<DateTime?>? restorableDate = null;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(i18n.createHabit,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headlineSmall),
                      ])),
              const SizedBox(height: 16),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Wrap(
                        runSpacing: 8.0,
                        children: [
                          InputField(
                            hintText: i18n.habitTitle,
                            controller: _emailController,
                            validations: [
                              requiredField,
                            ],
                          ),
                          InputField(
                            hintText: i18n.habitDescription,
                            minLines: 3,
                            validations: [
                              minLength(8),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        runSpacing: 8.0,
                        children: [
                          MasterValueDate(
                            label: i18n.startDate,
                            icon: Icons.calendar_today_rounded,
                            controller: _startDateController,
                          ),
                          MasterValueDate(
                            label: i18n.endDate,
                            icon: Icons.calendar_today_rounded,
                            controller: _endDateController,
                          ),
                          MasterValueFrequency(
                            controller: _frequencyController,
                            label: i18n.frequency,
                          ),
                          // MasterValueField<String>(
                          //   label: i18n.frequency,
                          //   hintText: 'Todos los días',
                          //   icon: Icon(
                          //     Icons.calendar_today_rounded,
                          //     color: const AppColors().accentColor,
                          //     size: 24,
                          //   ),
                          //   controller: _startDateController,
                          //   onTap: () {
                          //     _startDateController.setValue(null);
                          //   },
                          // ),
                          // MasterValueField<String>(
                          //   label: i18n.hours,
                          //   hintText: '--:-- hrs',
                          //   icon: Icon(
                          //     Icons.calendar_today_rounded,
                          //     color: const AppColors().accentColor,
                          //     size: 24,
                          //   ),
                          //   controller: _startDateController,
                          //   onTap: () {
                          //     _startDateController.setValue(null);
                          //   },
                          // ),
                          // MasterValueField<String>(
                          //   label: i18n.notify,
                          //   hintText: 'DD/MM/YYYY',
                          //   icon: Icon(
                          //     Icons.calendar_today_rounded,
                          //     color: const AppColors().accentColor,
                          //     size: 24,
                          //   ),
                          //   controller: _startDateController,
                          //   onTap: () {
                          //     _startDateController.setValue(null);
                          //   },
                          // ),
                          // MasterValueField<String>(
                          //   label: i18n.record,
                          //   hintText: 'DD/MM/YYYY',
                          //   icon: Icon(
                          //     Icons.calendar_today_rounded,
                          //     color: const AppColors().accentColor,
                          //     size: 24,
                          //   ),
                          //   controller: _startDateController,
                          //   onTap: () {
                          //     _startDateController.setValue(null);
                          //   },
                          // ),
                          // MasterValueField<String>(
                          //   label: i18n.habitCategory,
                          //   hintText: 'DD/MM/YYYY',
                          //   icon: Icon(
                          //     Icons.calendar_today_rounded,
                          //     color: const AppColors().accentColor,
                          //     size: 24,
                          //   ),
                          //   controller: _startDateController,
                          //   onTap: () {
                          //     _startDateController.setValue(null);
                          //   },
                          // ),
                          // MasterValueField<String>(
                          //   label: i18n.action,
                          //   hintText: 'Ninguna',
                          //   icon: Icon(
                          //     Icons.calendar_today_rounded,
                          //     color: const AppColors().accentColor,
                          //     size: 24,
                          //   ),
                          //   controller: _startDateController,
                          //   onTap: () {
                          //     _startDateController.setValue(null);
                          //   },
                          // ),
                          Center(
                            child: Button(
                              text: i18n.save,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
