import 'package:flutter/material.dart';

class QPayTheme {
  static const Color primaryColor = Color(0xFF00B462);
  static const Color primaryDark = Color(0xFF009E56);
  static const Color textColor = Color(0xFF333333);
  static const Color borderColor = Color(0xFFDDDDDD);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
