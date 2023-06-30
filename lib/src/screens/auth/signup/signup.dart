import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../components/button.dart';
import '../../../components/inputs/input_field.dart';
import '../../../components/lang_selector/lang_selector.dart';
import '../../../helpers/forms/validation_mixin.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            const Align(alignment: Alignment.topRight, child: LangSelector()),
            const SizedBox(height: 30),
            Center(child: Image.asset('assets/Logo.png', width: 325)),
            const SizedBox(height: 40),
            Text(i18n.register,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall),
            Row(
              children: [
                Text(i18n.alreadyHaveAccount,
                    style: Theme.of(context).textTheme.labelSmall),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(i18n.loginHere),
                )
              ],
            ),
            const SizedBox(height: 16),
            Form(
                key: _formKey,
                child: Wrap(runSpacing: 16, children: [
                  InputField(
                    hintText: i18n.fullName,
                    validations: [requiredField, minLength(6)],
                  ),
                  InputField(
                    hintText: i18n.email,
                    validations: [
                      requiredField,
                      validateEmail,
                    ],
                  ),
                  InputField(
                    hintText: i18n.username,
                    validations: [requiredField, minLength(6)],
                  ),
                  InputField(
                    hintText: i18n.password,
                    validations: [
                      requiredField,
                      validatePassword,
                      minLength(6)
                    ],
                  ),
                  InputField(
                    hintText: i18n.confirmPassword,
                    validations: [
                      requiredField,
                      validatePassword,
                      minLength(6)
                    ],
                  ),
                  Center(
                    child: Button(
                      text: i18n.signup,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')));
                        }
                      },
                    ),
                  )
                ]))
          ],
        ),
      )),
    ));
  }
}
