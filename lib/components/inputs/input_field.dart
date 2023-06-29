import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'constants.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.hintText,
    this.keyboardType,
    this.validations,
    this.isPassword = false,
  }) : super(key: key);

  final String hintText;
  final TextInputType? keyboardType;
  final List<String? Function(String)>? validations;
  final bool? isPassword;

  String? handleValidations(String? value) {
    if (validations == null) {
      return null;
    }
    for (var validation in validations!) {
      final error = validation(value!);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  var _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_showPassword && widget.isPassword!,
      keyboardType: widget.keyboardType,
      cursorColor: const AppColors().primaryColor,
      validator: (value) {
        return widget.handleValidations(value);
      },
      style: stylesForText,
      decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
          filled: true,
          errorMaxLines: 3,
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 40,
            maxWidth: 48,
          ),
          suffixIcon: widget.isPassword!
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: const AppColors().accentColor,
                    size: 26.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
          fillColor: const AppColors().accentColor25,
          hintStyle: TextStyle(color: const AppColors().accentColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12)),
    );
  }
}
