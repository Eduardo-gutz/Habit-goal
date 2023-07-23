import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_goal/src/components/calendar/calendar_days.dart';
import 'package:habit_goal/src/components/calendar/day.dart';

void main() {
  group('CalendarDays', () {
    testWidgets('renders days correctly', (WidgetTester tester) async {
      final marks = [
        MarkDay(date: DateTime(2023, 9, 1), color: Colors.red),
        MarkDay(date: DateTime(2023, 9, 2), color: Colors.green),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarDays(
              marks: marks,
              showToday: true,
              disabledDays: [
                DateTime(2023, 9, 3),
                DateTime(2023, 9, 4),
              ],
              onTapDay: (DateTime date) {},
            ),
          ),
        ),
      );

      expect(find.text('15'), findsWidgets);
      expect(find.text('25'), findsWidgets);
      expect(find.text('20'), findsOneWidget);
      expect(find.text('24'), findsOneWidget);
      expect(find.text('16'), findsOneWidget);
      expect(find.text('17'), findsOneWidget);
      expect(find.text('31'), findsOneWidget);

      final redBox = tester.widget<Day>(
        find.descendant(
          of: find.text('1'),
          matching: find.byType(Day),
        ),
      );
      expect(redBox.disabled, isFalse);
      expect(redBox.selected, isTrue);
      expect(redBox.selectedColor, equals(Colors.red));

      final greenBox = tester.widget<Day>(
        find.descendant(
          of: find.text('2'),
          matching: find.byType(Day),
        ),
      );
      expect(greenBox.disabled, isFalse);
      expect(greenBox.selected, isTrue);
      expect(greenBox.selectedColor, equals(Colors.green));

      final disabledBox = tester.widget<Day>(
        find.descendant(
          of: find.text('3'),
          matching: find.byType(Day),
        ),
      );
      expect(disabledBox.disabled, isTrue);
      expect(disabledBox.selected, isFalse);

      final todayBox = tester.widget<Day>(
        find.descendant(
          of: find.text(DateTime.now().day.toString()),
          matching: find.byType(Day),
        ),
      );
      expect(todayBox.disabled, isFalse);
      expect(todayBox.selected, isTrue);
      expect(todayBox.selectedColor, equals(Colors.blue));
    });

    testWidgets('calls onTapDay when a day is tapped',
        (WidgetTester tester) async {
      DateTime? tappedDate;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarDays(
              onTapDay: (DateTime date) {
                tappedDate = date;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('1'));
      expect(tappedDate, equals(DateTime.now().subtract(Duration(days: 6))));

      await tester.tap(find.text('15'));
      expect(tappedDate, equals(DateTime.now().subtract(Duration(days: 22))));
    });
  });
}
