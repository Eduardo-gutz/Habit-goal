import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';

class IconPressable extends StatelessWidget {
  const IconPressable({
    Key? key,
    this.dark = false,
    this.onPress,
    required this.icon,
  }) : super(key: key);

  final bool dark;
  final void Function()? onPress;
  final IconData icon;

  final _appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
      ),
      icon: Icon(
        icon,
        color: dark ? _appColors.black : _appColors.white,
      ),
      onPressed: onPress,
    );
  }
}
