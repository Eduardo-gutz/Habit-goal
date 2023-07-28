import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:habit_goal/src/components/button.dart';
import 'package:habit_goal/src/components/master_value/master_value_bool.dart';
import 'package:habit_goal/src/components/master_value/master_value_date.dart';
import 'package:habit_goal/src/components/inputs/input_field.dart';
import 'package:habit_goal/src/components/master_value/master_value_freq.dart';
import 'package:habit_goal/src/components/master_value/master_value_hour.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import 'package:habit_goal/src/helpers/forms/validation_mixin.dart';

class NewHabitScreen extends StatefulWidget {
  const NewHabitScreen({Key? key}) : super(key: key);

  @override
  State<NewHabitScreen> createState() => _NewHabitScreen();
}

class _NewHabitScreen extends State<NewHabitScreen> with ValidationMixin {
  final _emailController = TextEditingController();
  final _startDateController = MasterValueController<DateTime>();
  final _endDateController = MasterValueController<DateTime>();
  final _frequencyController = MasterValueController<String>();
  final _timeController = MasterValueController<TimeOfDay>();
  final _notifyController = MasterValueController<bool>();
  final _formKey = GlobalKey<FormState>();

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
                            icon: TablerIcons.calendar_star,
                            controller: _startDateController,
                          ),
                          MasterValueDate(
                            label: i18n.endDate,
                            icon: TablerIcons.calendar_check,
                            controller: _endDateController,
                          ),
                          MasterValueFrequency(
                            controller: _frequencyController,
                          ),
                          MasterValueHour(
                            controller: _timeController,
                          ),
                          MasterValueBoolean(
                            controller: _notifyController,
                            label: i18n.notify,
                          ),
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
