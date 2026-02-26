import 'dart:async';

typedef PaymentChecker = Future<bool> Function(String invoiceId);

class PaymentPoller {
  final PaymentChecker checker;
  final Duration interval;
  final Duration timeout;

  PaymentPoller({
    required this.checker,
    this.interval = const Duration(seconds: 3),
    this.timeout = const Duration(minutes: 5),
  });

  Future<bool> poll(String invoiceId) async {
    final deadline = DateTime.now().add(timeout);

    while (DateTime.now().isBefore(deadline)) {
      final isPaid = await checker(invoiceId);
      if (isPaid) return true;
      await Future.delayed(interval);
    }

    return false;
  }
}
