import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  final void Function() onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text,
          style: TextStyle(
              fontSize: 18,
              color: const AppColors().white,
              fontWeight: FontWeight.bold)),
    );
  }
}
