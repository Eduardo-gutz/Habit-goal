import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_goal/src/bloc/auth/auth_bloc.dart';
import 'package:habit_goal/src/bloc/auth/auth_events.dart';
import 'package:habit_goal/src/models/auth_models.dart';
import 'package:habit_goal/src/provider/locale_provider.dart';
import 'package:habit_goal/src/services/auth.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  String currentLang = 'en';

  Map handleFullName(String fullName) {
    final List<String> nameSplit = fullName.split(' ');
    final nameLength = nameSplit.length;
    return {
      'name': nameSplit[0],
      'lastname': nameLength > 1 ? nameSplit[1] : null,
      'secondLastname': nameLength > 2 ? nameSplit[2] : null,
    };
  }

  Future handleSignup(BuildContext context) async {
    var authState = context.read<AuthBloc>();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map nameSplit = handleFullName(_fullnameController.text);

      final NewUserDTO newUser = NewUserDTO(
        email: _emailController.text,
        username: _usernameController.text,
        name: nameSplit['name'],
        lastname: nameSplit['lastname'],
        secondLastname: nameSplit['secondLastname'],
      );

      newUser.pass = _passwordController.text;

      try {
        final response =
            await AuthService().singupWithPass(newUser, currentLang);

        authState.add(SetAuthState(isAuth: true, userAuth: response));

        if (context.mounted) {
          Navigator.pushNamed(context, '/home');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    final provider = Provider.of<LocaleProvider>(context);

    setState(() {
      currentLang = provider.locale.toString();
    });

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
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Form(
                key: _formKey,
                child: Wrap(runSpacing: 16, children: [
                  InputField(
                    controller: _fullnameController,
                    hintText: i18n.fullName,
                    validations: [requiredField, minLength(6)],
                  ),
                  InputField(
                    controller: _emailController,
                    hintText: i18n.emailAddress,
                    validations: [
                      requiredField,
                      validateEmail,
                    ],
                  ),
                  InputField(
                    controller: _usernameController,
                    hintText: i18n.username,
                    validations: [requiredField, minLength(6)],
                  ),
                  InputField(
                    controller: _passwordController,
                    hintText: i18n.password,
                    validations: [
                      requiredField,
                      validatePassword,
                      minLength(6)
                    ],
                  ),
                  InputField(
                    controller: _confirmController,
                    hintText: i18n.confirmPassword,
                    validations: [
                      requiredField,
                      minLength(6),
                      confirmPassword(_passwordController.text)
                    ],
                  ),
                  Center(
                    child: Button(
                      text: i18n.signup,
                      onPress: () {
                        handleSignup(context);
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
