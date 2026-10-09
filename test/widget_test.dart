import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4_mobile/main.dart';
import 'package:lab4_mobile/tasks/task_01_selection_controls.dart';
import 'package:lab4_mobile/tasks/task_02_input_fields.dart';
import 'package:lab4_mobile/tasks/task_03_buttons.dart';
import 'package:lab4_mobile/tasks/task_06_sliders_pickers.dart';
import 'package:lab4_mobile/tasks/task_07_scrollable_list.dart';
import 'package:lab4_mobile/tasks/task_10_containers.dart';

Widget _wrap(Widget screen) => MaterialApp(home: screen);

void main() {
  testWidgets('Home screen lists the core example and tasks', (tester) async {
    await tester.pumpWidget(const Lab4App());
    expect(find.text('Core Example'), findsOneWidget);
    expect(find.text('Task 1'), findsOneWidget);
  });

  testWidgets('Task 1: Continue is enabled only after agreeing to terms', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const SelectionControlsScreen()));

    ElevatedButton button() =>
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    expect(button().onPressed, isNull);
    await tester.tap(find.text('Agree to Terms'));
    await tester.pump();
    expect(button().onPressed, isNotNull);
  });

  testWidgets('Task 2: email without @ fails validation', (tester) async {
    await tester.pumpWidget(_wrap(const LoginFormScreen()));

    await tester.enterText(find.byType(TextFormField).first, 'user.example');
    await tester.enterText(find.byType(TextFormField).last, 'secret');
    await tester.tap(find.text('Log In'));
    await tester.pump();
    expect(find.text('Email must contain an @ symbol'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'user@example');
    await tester.tap(find.text('Log In'));
    await tester.pump();
    expect(find.text('Email must contain an @ symbol'), findsNothing);
  });

  testWidgets('Task 3: FAB increments and Reset clears the counter', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const CounterScreen()));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Task 6: slider updates the percentage text', (tester) async {
    await tester.pumpWidget(_wrap(const SlidersPickersScreen()));
    expect(find.text('50%'), findsOneWidget);

    await tester.drag(find.byType(Slider), const Offset(-1000, 0));
    await tester.pump();
    expect(find.text('0%'), findsOneWidget);
  });

  testWidgets('Task 7: swiping removes an item', (tester) async {
    await tester.pumpWidget(_wrap(const DynamicListScreen()));
    expect(find.text('List item 1'), findsOneWidget);

    await tester.drag(find.text('List item 1'), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(find.text('List item 1'), findsNothing);
    expect(find.text('Task 7: List (19 items)'), findsOneWidget);
  });

  testWidgets('Task 10: ExpansionTile reveals its answer', (tester) async {
    await tester.pumpWidget(_wrap(const ContainersScreen()));
    expect(find.textContaining('open-source UI toolkit'), findsNothing);

    await tester.tap(find.text('What is Flutter?'));
    await tester.pumpAndSettle();
    expect(find.textContaining('open-source UI toolkit'), findsOneWidget);
  });
}
