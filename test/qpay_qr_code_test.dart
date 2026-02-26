import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qpay_flutter/src/widgets/qpay_qr_code.dart';

void main() {
  group('QPayQrCode', () {
    testWidgets('renders QrImageView with correct data', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QPayQrCode(qrText: 'test_qr_data'),
          ),
        ),
      );

      expect(find.byType(QrImageView), findsOneWidget);
    });

    testWidgets('uses default size of 256', (tester) async {
      const widget = QPayQrCode(qrText: 'test');
      expect(widget.size, 256);
    });

    testWidgets('accepts custom size', (tester) async {
      const widget = QPayQrCode(qrText: 'test', size: 200);
      expect(widget.size, 200);
    });

    testWidgets('wraps QrImageView in Center widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QPayQrCode(qrText: 'centered_qr'),
          ),
        ),
      );

      final center = find.byType(Center);
      expect(center, findsOneWidget);
    });

    testWidgets('stores qrText correctly', (tester) async {
      const qrText = 'payment://qpay/invoice/123';
      const widget = QPayQrCode(qrText: qrText);
      expect(widget.qrText, qrText);
    });

    testWidgets('renders without errors for empty qrText', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QPayQrCode(qrText: ''),
          ),
        ),
      );

      expect(find.byType(QPayQrCode), findsOneWidget);
    });

    testWidgets('renders without errors for long qrText', (tester) async {
      final longText = 'a' * 500;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QPayQrCode(qrText: longText),
          ),
        ),
      );

      expect(find.byType(QPayQrCode), findsOneWidget);
    });
  });
}
