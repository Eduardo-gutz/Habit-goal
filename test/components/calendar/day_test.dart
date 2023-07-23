// BEGIN: 8f7a2b5f4c7d
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_goal/src/components/calendar/day.dart';
import 'package:habit_goal/src/theme/colors.dart';

void main() {
  group('Day', () {
    testWidgets('renders day number', (WidgetTester tester) async {
      final day = DateTime(2022, 12, 1);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Day(date: day),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      final day = DateTime(2022, 12, 1);
      var tapped = false;
      var dateTaped = DateTime(2022, 12, 5);
      void handleTap(DateTime date) {
        dateTaped = date;
        tapped = true;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Day(date: day, onTap: handleTap),
          ),
        ),
      );

      await tester.tap(find.byType(Day));
      expect(tapped, isTrue);
      expect(dateTaped, equals(day));
    });

    testWidgets('displays selected color when selected',
        (WidgetTester tester) async {
      final day = DateTime(2022, 12, 1);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Day(date: day, selected: true, selectedColor: Colors.red),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.red.withOpacity(.2)));
    });

    testWidgets('displays disabled style when disabled',
        (WidgetTester tester) async {
      final day = DateTime(2022, 12, 1);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Day(date: day, disabled: true),
          ),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(
          text.style!.color, equals(const AppColors().white.withOpacity(.5)));
      expect(text.style!.fontWeight, equals(FontWeight.w300));
    });
  });
}
