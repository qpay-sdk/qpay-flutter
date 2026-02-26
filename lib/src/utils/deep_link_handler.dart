import 'package:url_launcher/url_launcher.dart';

class QPayDeepLinkHandler {
  static Future<bool> launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
