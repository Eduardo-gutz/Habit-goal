import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_goal/components/lang_selector/lang_selector.dart';
import 'package:habit_goal/theme/constants.dart';

import '../../components/button.dart';
import '../../components/inputs/input_field.dart';
import '../../helpers/forms/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String lang = 'en';

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Localizations.override(
      context: context,
      locale: const Locale('es'),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: appColors.white,
            actions: const [
              LangSelector(),
            ],
          ),
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                Center(child: Image.asset('assets/Logo.png', width: 325)),
                const SizedBox(height: 53),
                Text(i18n.log,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall),
                Row(
                  children: [
                    Text(i18n.noAccount,
                        style: Theme.of(context).textTheme.labelSmall),
                    TextButton(
                      onPressed: () {},
                      child: Text(i18n.signUp),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Form(
                    key: _formKey,
                    child: Wrap(runSpacing: 16, children: [
                      InputField(
                        hintText: i18n.email,
                        keyboardType: TextInputType.emailAddress,
                        validations: [
                          requiredField,
                        ],
                      ),
                      InputField(
                        hintText: i18n.password,
                        isPassword: true,
                        validations: [
                          requiredField,
                          minLength(8),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(
                            fontSize: 16,
                          )),
                        ),
                        child: Text(i18n.forgotPassword),
                      ),
                      Center(
                        child: Button(
                          text: i18n.login,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));
                            }
                          },
                        ),
                      )
                    ]))
              ],
            ),
          ))),
    );
  }
}
