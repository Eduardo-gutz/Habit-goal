import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/locale_provider.dart';
import '../../theme/colors.dart';

class LangSelector extends StatefulWidget {
  const LangSelector({Key? key}) : super(key: key);

  @override
  State<LangSelector> createState() => _LangSelectorState();
}

class _LangSelectorState extends State<LangSelector> {
  String lang = 'en';
  static final appColors = AppColors();

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return appColors.secondaryColor;
    }
    return appColors.accentColor25;
  }

  TextStyle getColorFont(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: appColors.accentColor25,
      );
    }
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: appColors.accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return SegmentedButton(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: MaterialStateProperty.resolveWith(getColorFont),
        visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(getColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      showSelectedIcon: false,
      segments: const [
        ButtonSegment<String>(
          value: 'es',
          label: Text('ES'),
        ),
        ButtonSegment<String>(value: 'en', label: Text('EN')),
      ],
      selected: {provider.locale.languageCode},
      onSelectionChanged: (Set<String> newLang) {
        setState(() {
          lang = newLang.first;
          provider.setLocale(Locale(lang));
        });
      },
    );
  }
}
