// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/src/http/mock_client.dart';
import 'package:form_app/src/sign_in_http.dart';
import 'package:form_app/src/form_widgets.dart';

void main() {
  Future<void> _enterFormWidgetsScreen(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FormWidgetsDemo(),
    ));

    await tester.pumpAndSettle();
  }

  testWidgets(
      'Given the user navigates to the Form Widgets screen'
      'When the user types into the title text field'
      'Then the TextFormField widget should contain the matching text',
      (WidgetTester tester) async {
    await _enterFormWidgetsScreen(tester);

    var titleTextFormField = find.byKey(ValueKey("title_text_field"));
    await tester.enterText(titleTextFormField, "Know Thyself");

    await tester.pumpAndSettle();

    expect(find.text("Know Thyself"), findsOneWidget);
    expect(find.text("Know Thyselves"), findsNothing);
  });

  testWidgets(
      'Given the user navigates to the Form Widgets screen'
      'When the user selects a date from the DatePicker'
      'Then the DatePicker\'s value should be the picked date',
      (WidgetTester tester) async {
    await _enterFormWidgetsScreen(tester);

    var datePickerFieldEditButton =
        find.byKey(ValueKey("form_date_picker_edit"));
    await tester.tap(datePickerFieldEditButton);

    await tester.pumpAndSettle();

    await tester.tap(find.text("15"));
    await tester.tap(find.text("OK"));

    await tester.pumpAndSettle();

    expect(find.textContaining("/15/"), findsOneWidget);
    expect(find.textContaining("/14/"), findsNothing);
    expect(find.textContaining("/16/"), findsNothing);
  });

  testWidgets(
      'Given the user navigates to the Form Widgets screen'
      'When the user slides the Estimated Value Slider to a certain value'
      'Then the Estimated Value Slider\'s value should be the specified value',
      (WidgetTester tester) async {
    await _enterFormWidgetsScreen(tester);

    var estimatedValueSlider = find.byKey(ValueKey("estimated_value_slider"));
    await tester.drag(estimatedValueSlider, Offset(100, 0));

    await tester.pumpAndSettle();

    // FIND WAY TO GET EXACT VALUE OF ESTIMATEDVALUESLIDER in order to make comparison

    // expect(find.textContaining("/15/"), findsOneWidget);
    // expect(find.textContaining("/14/"), findsNothing);
    // expect(find.textContaining("/16/"), findsNothing);
  });
}
