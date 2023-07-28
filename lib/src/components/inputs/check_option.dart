import 'package:flutter/material.dart';
import 'package:habit_goal/src/components/inputs/check_box.dart';
import 'package:habit_goal/src/theme/colors.dart';

import '../../controllers/fields_controller.dart';

class CheckOption<T> extends StatefulWidget {
  const CheckOption({
    Key? key,
    required this.label,
    required this.value,
    this.onChange,
    this.controller,
  }) : super(key: key);

  final String label;
  final T value;
  final Function(T?)? onChange;
  final MasterValueController<T>? controller;

  @override
  State<CheckOption<T>> createState() => _CheckOptionState();
}

class _CheckOptionState<T> extends State<CheckOption<T>> {
  bool _isChecked = false;
  final _appColors = const AppColors();

  void _onChange(bool value) {
    if (widget.controller != null) {
      widget.controller!.setValue(widget.value);
    }

    print(widget.controller!.value);

    setState(() {
      _isChecked = value;
    });

    if (widget.onChange == null) {
      return;
    }

    if (!value) {
      widget.onChange!(null);
      return;
    }
    widget.onChange!(widget.value);
  }

  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {
        _isChecked = widget.controller!.value == widget.value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: _appColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        CheckBox(
          value: widget.controller != null
              ? (widget.controller!.value == widget.value)
              : _isChecked,
          onChange: _onChange,
        ),
      ],
    );
  }
}
