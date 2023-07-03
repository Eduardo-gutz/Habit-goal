import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_goal/src/services/auth.dart';

import '../../../components/button.dart';
import '../../../components/inputs/input_field.dart';
import '../../../components/lang_selector/lang_selector.dart';
import '../../../helpers/forms/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final response = await AuthService()
            .login(_emailController.text, _passwordController.text);
        print(response);
      } catch (e) {
        print(e.toString());
      }
    }
  }

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
            const SizedBox(height: 35),
            Center(child: Image.asset('assets/Logo.png', width: 325)),
            const SizedBox(height: 53),
            Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i18n.log,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Row(
                        children: [
                          Text(i18n.noAccount,
                              style: Theme.of(context).textTheme.labelSmall),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(i18n.signUp),
                          )
                        ],
                      ),
                    ])),
            const SizedBox(height: 16),
            Form(
                key: _formKey,
                child: Wrap(runSpacing: 16, children: [
                  InputField(
                    hintText: i18n.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validations: [
                      requiredField,
                    ],
                  ),
                  InputField(
                    hintText: i18n.password,
                    isPassword: true,
                    controller: _passwordController,
                    validations: [
                      requiredField,
                      minLength(8),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      textStyle:
                          MaterialStateProperty.all<TextStyle>(const TextStyle(
                        fontSize: 16,
                      )),
                    ),
                    child: Text(i18n.forgotPassword),
                  ),
                  Center(
                    child: Button(
                      text: i18n.login,
                      onPress: handleLogin,
                    ),
                  )
                ]))
          ],
        ),
      )),
    ));
  }
}
