import 'package:flutter_test/flutter_test.dart';
import 'package:qpay_flutter/src/utils/payment_poller.dart';

void main() {
  group('PaymentPoller', () {
    test('returns true when payment is immediately confirmed', () async {
      final poller = PaymentPoller(
        checker: (invoiceId) async => true,
        interval: const Duration(milliseconds: 10),
        timeout: const Duration(seconds: 5),
      );

      final result = await poller.poll('inv_123');
      expect(result, isTrue);
    });

    test('returns true when payment is confirmed after retries', () async {
      int callCount = 0;
      final poller = PaymentPoller(
        checker: (invoiceId) async {
          callCount++;
          return callCount >= 3;
        },
        interval: const Duration(milliseconds: 10),
        timeout: const Duration(seconds: 5),
      );

      final result = await poller.poll('inv_456');
      expect(result, isTrue);
      expect(callCount, 3);
    });

    test('returns false when timeout is reached', () async {
      final poller = PaymentPoller(
        checker: (invoiceId) async => false,
        interval: const Duration(milliseconds: 10),
        timeout: const Duration(milliseconds: 50),
      );

      final result = await poller.poll('inv_timeout');
      expect(result, isFalse);
    });

    test('passes correct invoiceId to checker', () async {
      String? receivedId;
      final poller = PaymentPoller(
        checker: (invoiceId) async {
          receivedId = invoiceId;
          return true;
        },
        interval: const Duration(milliseconds: 10),
        timeout: const Duration(seconds: 5),
      );

      await poller.poll('inv_check_id');
      expect(receivedId, 'inv_check_id');
    });

    test('uses default interval of 3 seconds', () {
      final poller = PaymentPoller(
        checker: (id) async => true,
      );
      expect(poller.interval, const Duration(seconds: 3));
    });

    test('uses default timeout of 5 minutes', () {
      final poller = PaymentPoller(
        checker: (id) async => true,
      );
      expect(poller.timeout, const Duration(minutes: 5));
    });

    test('accepts custom interval', () {
      final poller = PaymentPoller(
        checker: (id) async => true,
        interval: const Duration(seconds: 10),
      );
      expect(poller.interval, const Duration(seconds: 10));
    });

    test('accepts custom timeout', () {
      final poller = PaymentPoller(
        checker: (id) async => true,
        timeout: const Duration(minutes: 10),
      );
      expect(poller.timeout, const Duration(minutes: 10));
    });

    test('checker is called at least once before timeout', () async {
      int callCount = 0;
      final poller = PaymentPoller(
        checker: (invoiceId) async {
          callCount++;
          return false;
        },
        interval: const Duration(milliseconds: 20),
        timeout: const Duration(milliseconds: 50),
      );

      await poller.poll('inv_count');
      expect(callCount, greaterThanOrEqualTo(1));
    });

    test('propagates checker exceptions', () async {
      final poller = PaymentPoller(
        checker: (invoiceId) async {
          throw Exception('Network error');
        },
        interval: const Duration(milliseconds: 10),
        timeout: const Duration(seconds: 5),
      );

      expect(() => poller.poll('inv_error'), throwsException);
    });
  });
}
