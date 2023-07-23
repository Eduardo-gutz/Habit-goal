import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPress,
    required this.text,
    this.secondary = false,
    this.textColor,
  }) : super(key: key);

  final void Function() onPress;
  final String text;
  final bool secondary;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        side: secondary
            ? BorderSide(
                color: const AppColors().secondaryColor,
                width: 1.5,
              )
            : null,
        backgroundColor:
            secondary ? Colors.transparent : const AppColors().secondaryColor,
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 18,
              color: textColor ?? const AppColors().white,
              fontWeight: FontWeight.bold)),
    );
  }
}
