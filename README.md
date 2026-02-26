# qpay_flutter

[![pub](https://img.shields.io/pub/v/qpay_flutter)](https://pub.dev/packages/qpay_flutter)
[![CI](https://github.com/qpay-sdk/qpay-flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/qpay-sdk/qpay-flutter/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

QPay V2 payment UI widgets for Flutter.

## Install

```yaml
dependencies:
  qpay_flutter: ^1.0.0
```

## Widgets

### QR Code

```dart
QPayQrCode(qrText: invoice.qrText)
```

### Payment Sheet

```dart
QPayPaymentSheet.show(
  context,
  qrText: invoice.qrText,
  banks: invoice.urls.map((u) => QPayBankItem(
    name: u.name,
    logo: u.logo,
    link: u.link,
  )).toList(),
);
```

### Payment Button

```dart
QPayPaymentButton(
  qrText: invoice.qrText,
  banks: bankItems,
)
```

### Payment Poller

```dart
final poller = PaymentPoller(
  checker: (id) async {
    final result = await client.checkPayment(...);
    return result.rows.isNotEmpty;
  },
);
final paid = await poller.poll(invoice.invoiceId);
```

## License

MIT
