import 'package:flutter/material.dart';
import 'package:habit_goal/src/controllers/fields_controller.dart';
import '../../theme/colors.dart';

class MasterValueField<V> extends StatefulWidget {
  const MasterValueField({
    Key? key,
    this.renderValue,
    this.hintText,
    required this.controller,
    this.onTap,
    this.validations,
    required this.label,
    this.icon,
  }) : super(key: key);

  final Widget Function(V?)? renderValue;
  final String? hintText;
  final String label;
  final IconData? icon;
  final MasterValueController<V> controller;
  final void Function()? onTap;
  final List<String? Function(V)>? validations;

  String? handleValidations(V? value) {
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
  State<MasterValueField<V>> createState() => _MasterValueFieldState<V>();
}

class _MasterValueFieldState<V> extends State<MasterValueField<V>> {
  late FormFieldState<V>? _field = null;

  handleRenderValue(V? value) {
    if (widget.renderValue != null) {
      return widget.renderValue!(value);
    }
    return Text(
      value?.toString() ?? widget.hintText ?? '',
      style: TextStyle(
        color: const AppColors().accentColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  @override
  void initState() {
    widget.controller.addListener(() {
      _field?.didChange(widget.controller.value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: widget.handleValidations,
      builder: (FormFieldState<V> field) {
        if (_field != field) {
          _field = field;
        }
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const AppColors().accentColor25,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.icon != null
                          ? Icon(
                              widget.icon,
                              color: const AppColors().accentColor,
                              size: 24,
                            )
                          : const SizedBox(),
                      const SizedBox(width: 8),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: const AppColors().black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  handleRenderValue(field.value)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
