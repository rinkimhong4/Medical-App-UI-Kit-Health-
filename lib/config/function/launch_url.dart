import 'package:url_launcher/url_launcher.dart';

/// url_launcher
/// HTTP Laugnch
/// facebook
/// IG
/// Website
/// LaunchUrl.launch('https://www.facebook.com/example');

class LaunchUrl {
  static Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// usage
  /// LaunchUrl.launchPhone('+1234567890');
  static Future<void> launchPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch phone $phoneNumber';
    }
  }

  ///uage
  /// LaunchUrl.launchEmail('support@example.com');
  static Future<void> launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch email $email';
    }
  }

  /// usgae
  /// LaunchUrl.launchWhatsApp('1234567890');
  static Future<void> launchWhatsApp(String phoneNumber) async {
    final Uri uri = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp for $phoneNumber';
    }
  }
}
