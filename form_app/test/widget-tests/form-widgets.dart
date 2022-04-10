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

    // Enter email / password
    // var emailField = textFormField.at(0);
    // var passwordField = textFormField.at(1);
    // await tester.enterText(emailField, email);
    // await tester.enterText(passwordField, password);

    // Sign in
    // var button = find.byType(TextButton);
    // expect(button, findsOneWidget);
    // await tester.tap(button);

    // Wait for dialog
    await tester.pumpAndSettle();
    // expect(find.byType(AlertDialog), findsOneWidget);
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
}
