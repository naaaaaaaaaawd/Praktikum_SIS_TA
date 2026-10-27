import 'package:challenge3/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('successful login opens the main screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: LoginPage()),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.ensureVisible(find.text('Masuk'));
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Warung IS - Menu'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsNothing);
  });
}
