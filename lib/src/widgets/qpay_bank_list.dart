import 'package:flutter/material.dart';
import '../utils/deep_link_handler.dart';
import '../theme/qpay_theme.dart';

class QPayBankItem {
  final String name;
  final String description;
  final String logo;
  final String link;

  const QPayBankItem({
    required this.name,
    this.description = '',
    this.logo = '',
    required this.link,
  });
}

class QPayBankList extends StatelessWidget {
  final List<QPayBankItem> banks;

  const QPayBankList({super.key, required this.banks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: banks.length,
      itemBuilder: (context, index) {
        final bank = banks[index];
        return ListTile(
          leading: bank.logo.isNotEmpty
              ? Image.network(bank.logo, width: 40, height: 40, errorBuilder: (_, __, ___) => const Icon(Icons.account_balance))
              : const Icon(Icons.account_balance),
          title: Text(bank.name, style: const TextStyle(color: QPayTheme.textColor)),
          subtitle: bank.description.isNotEmpty ? Text(bank.description) : null,
          onTap: () => QPayDeepLinkHandler.launch(bank.link),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: QPayTheme.borderColor),
          ),
        );
      },
    );
  }
}
