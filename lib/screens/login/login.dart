import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/Logo.png'),
          const Text(
            'Ingresa a tu cuenta',
          ),
          Row(
            children: [
              const Text('¿No tienes una cuenta?'),
              TextButton(
                onPressed: () {},
                child: const Text('Regístrate aquí'),
              )
            ],
          ),
          Form(
              key: _formKey,
              child: Wrap(runSpacing: 16, children: [
                InputField(
                  hintText: 'Correo o nombre de usuario',
                  keyboardType: TextInputType.emailAddress,
                  validations: [
                    requiredField,
                  ],
                ),
                InputField(
                  hintText: 'Contraseña',
                  isPassword: true,
                  validations: [
                    requiredField,
                    minLength(8),
                  ],
                ),
                Center(
                  child: Button(
                    text: 'Iniciar sesión',
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
    )));
  }
}
