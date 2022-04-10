// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/src/http/mock_client.dart';
import 'package:form_app/src/sign_in_http.dart';
import 'package:form_app/src/validation.dart';
import 'package:form_app/src/form_widgets.dart';
import '../extensions/slide-to.dart';

void main() {
  Future<void> _enterFormWidgetsScreen(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FormWidgetsDemo(),
    ));

    await tester.pumpAndSettle();
  }

  Future<void> _enterValidationScreen(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FormValidationDemo(),
    ));

    await tester.pumpAndSettle();
  }

  Future<void> _enterSignInScreen(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SignInHttpDemo(),
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

    await SlideTo(tester).slideToValue(estimatedValueSlider, 20);

    await tester.pumpAndSettle();

    Slider slider = tester.firstWidget(estimatedValueSlider);

    expect(slider.value, 100);
    expect(slider.value < 100, false);
    expect(slider.value > 100, false);
  });

  testWidgets(
      'Given the user navigates to the Validation screen'
      'When the user submits the form without any values'
      'Then error messages should be shown under the text fields',
      (WidgetTester tester) async {
    await _enterValidationScreen(tester);

    var submitButton = find.byKey(ValueKey("submit_button"));

    await tester.tap(submitButton);

    await tester.pumpAndSettle();

    expect(find.text("Please enter an adjective."), findsOneWidget);
    expect(find.text("Please enter a noun."), findsOneWidget);
    expect(
        find.text("You must agree to the terms of service."), findsOneWidget);
  });
}
