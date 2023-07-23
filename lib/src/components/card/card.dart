import 'package:flutter/material.dart';
import 'package:habit_goal/src/theme/colors.dart';

class CardHG extends StatelessWidget {
  const CardHG({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(8, 4, 8, 10),
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: padding,
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: const AppColors().accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
