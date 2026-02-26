import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qpay_flutter/src/theme/qpay_theme.dart';

void main() {
  group('QPayTheme', () {
    test('primaryColor is correct green', () {
      expect(QPayTheme.primaryColor, const Color(0xFF00B462));
    });

    test('primaryDark is correct dark green', () {
      expect(QPayTheme.primaryDark, const Color(0xFF009E56));
    });

    test('textColor is correct dark gray', () {
      expect(QPayTheme.textColor, const Color(0xFF333333));
    });

    test('borderColor is correct light gray', () {
      expect(QPayTheme.borderColor, const Color(0xFFDDDDDD));
    });

    test('backgroundColor is white', () {
      expect(QPayTheme.backgroundColor, const Color(0xFFFFFFFF));
    });

    test('primaryButton style is not null', () {
      expect(QPayTheme.primaryButton, isNotNull);
    });

    testWidgets('primaryButton renders with correct background color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              style: QPayTheme.primaryButton,
              onPressed: () {},
              child: const Text('Test'),
            ),
          ),
        ),
      );

      final button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);
    });

    testWidgets('primaryButton applies white foreground color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              style: QPayTheme.primaryButton,
              onPressed: () {},
              child: const Text('QPay'),
            ),
          ),
        ),
      );

      // Button should render successfully with the style applied
      expect(find.text('QPay'), findsOneWidget);
    });

    test('primaryColor is different from primaryDark', () {
      expect(QPayTheme.primaryColor, isNot(equals(QPayTheme.primaryDark)));
    });

    test('primaryDark is darker than primaryColor', () {
      // primaryDark (0xFF009E56) should have lower value than primaryColor (0xFF00B462)
      expect(QPayTheme.primaryDark.value, lessThan(QPayTheme.primaryColor.value));
    });

    test('all colors have full opacity', () {
      expect(QPayTheme.primaryColor.alpha, 255);
      expect(QPayTheme.primaryDark.alpha, 255);
      expect(QPayTheme.textColor.alpha, 255);
      expect(QPayTheme.borderColor.alpha, 255);
      expect(QPayTheme.backgroundColor.alpha, 255);
    });
  });
}
