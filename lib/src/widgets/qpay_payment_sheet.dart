import 'package:flutter/material.dart';
import 'qpay_qr_code.dart';
import 'qpay_bank_list.dart';

class QPayPaymentSheet extends StatelessWidget {
  final String qrText;
  final List<QPayBankItem> banks;
  final String? title;

  const QPayPaymentSheet({
    super.key,
    required this.qrText,
    required this.banks,
    this.title,
  });

  static Future<void> show(
    BuildContext context, {
    required String qrText,
    required List<QPayBankItem> banks,
    String? title,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => QPayPaymentSheet(
        qrText: qrText,
        banks: banks,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                title ?? 'QPay Төлбөр',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              QPayQrCode(qrText: qrText, size: 200),
              const SizedBox(height: 24),
              const Text('Банкны аппликейшнээр төлөх', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              QPayBankList(banks: banks),
            ],
          ),
        );
      },
    );
  }
}
