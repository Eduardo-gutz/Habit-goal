import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_goal/src/theme/colors.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    Key? key,
    this.value = false,
    this.onChange,
  }) : super(key: key);

  final bool value;
  final Function(bool)? onChange;

  void change() {
    if (onChange == null) {
      return;
    }
    onChange!(!value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: change,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: !value ? Colors.transparent : const AppColors().success,
          border: !value
              ? Border.fromBorderSide(
                  BorderSide(
                    color: const AppColors().secondaryColor,
                    width: 3,
                  ),
                )
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: value
            ? Center(
                child: SvgPicture.asset(
                  'assets/svg/check.svg',
                  semanticsLabel: 'check',
                ),
              )
            : null,
      ),
    );
  }
}
