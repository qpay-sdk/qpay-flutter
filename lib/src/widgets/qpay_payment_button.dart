import 'package:flutter/material.dart';
import '../theme/qpay_theme.dart';
import 'qpay_bank_list.dart';
import 'qpay_payment_sheet.dart';

class QPayPaymentButton extends StatelessWidget {
  final String qrText;
  final List<QPayBankItem> banks;
  final String label;
  final VoidCallback? onPressed;

  const QPayPaymentButton({
    super.key,
    required this.qrText,
    required this.banks,
    this.label = 'QPay-ээр төлөх',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: QPayTheme.primaryButton,
      onPressed: onPressed ?? () => QPayPaymentSheet.show(context, qrText: qrText, banks: banks),
      child: Text(label),
    );
  }
}
