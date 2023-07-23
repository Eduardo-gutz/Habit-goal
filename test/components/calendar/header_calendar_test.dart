import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_goal/src/components/calendar/header_calendar.dart';

void main() {
  group('HeaderCalendar', () {
    testWidgets('should display the correct month and year', (tester) async {
      // Arrange
      final widget = HeaderCalendar(
        initDate: DateTime(2022, 11, 1),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Act
      final monthText = find.text('November');
      final yearText = find.text('2022');

      // Assert
      expect(monthText, findsOneWidget);
      expect(yearText, findsOneWidget);
    });

    testWidgets(
        'should change to the next month when the next arrow is pressed',
        (tester) async {
      // Arrange
      final widget = HeaderCalendar(
        initDate: DateTime(2022, 11, 1),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Act
      final nextArrow = find.byIcon(Icons.arrow_forward_ios);
      await tester.tap(nextArrow);
      await tester.pump();

      // Assert
      final monthText = find.text('December');
      final yearText = find.text('2022');
      expect(monthText, findsOneWidget);
      expect(yearText, findsOneWidget);
    });

    testWidgets(
        'should change to the previous month when the back arrow is pressed',
        (tester) async {
      // Arrange
      final widget = HeaderCalendar(
        initDate: DateTime(2022, 11, 1),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Act
      final backArrow = find.byIcon(Icons.arrow_back_ios_new);
      await tester.tap(backArrow);
      await tester.pump();

      // Assert
      final monthText = find.text('October');
      final yearText = find.text('2022');
      expect(monthText, findsOneWidget);
      expect(yearText, findsOneWidget);
    });

    testWidgets('should call the onChange callback when the date is changed',
        (tester) async {
      // Arrange
      DateTime? selectedDate;
      final widget = HeaderCalendar(
        initDate: DateTime(2022, 11, 1),
        onChange: (date) => selectedDate = date,
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      // Act
      final nextArrow = find.byIcon(Icons.arrow_forward_ios);
      await tester.tap(nextArrow);
      await tester.pump();

      // Assert
      expect(selectedDate, equals(DateTime(2022, 12, 1)));
    });
  });
}
