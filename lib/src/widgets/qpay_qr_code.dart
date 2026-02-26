import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QPayQrCode extends StatelessWidget {
  final String qrText;
  final double size;

  const QPayQrCode({
    super.key,
    required this.qrText,
    this.size = 256,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: qrText,
        version: QrVersions.auto,
        size: size,
        gapless: true,
      ),
    );
  }
}
