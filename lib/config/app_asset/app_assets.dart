import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  bool get _isNetwork => path.startsWith('http');
  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isNetwork) {
      // network image
      if (_isSvg) {
        return SvgPicture.network(path, width: width, height: height, fit: fit);
      } else {
        return CachedNetworkImage(
          imageUrl: path,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    } else {
      // asset image
      if (_isSvg) {
        return SvgPicture.asset(path, width: width, height: height, fit: fit);
      } else {
        return Image.asset(path, width: width, height: height, fit: fit);
      }
    }
  }
}

//  usage AppImage(AppAssets.logo, width: 100, height: 100),
class AppAssets {
  // logo
  static const String logo1 = 'assets/logo/logo_1.png';
  static const String logo2 = 'assets/logo/logo_2.png';
  // bottom navigation icons
  static const String homeOutline = 'assets/icons/Home_outline.png';
  static const String homeFill = 'assets/icons/home_fill.png';
  static const String profileOutline = 'assets/icons/UserProfile_outline.png';
  static const String profileFill = 'assets/icons/user_fill.png';
  static const String bookingOutline = 'assets/icons/Booking_outline.png';
  static const String bookingFill = 'assets/icons/booking_fill.png';
  static const String messageOutline = 'assets/icons/Messages_outline.png';
  static const String messageFill = 'assets/icons/message_fill.png';
  static const String onboarding1 = 'assets/images/onborading1.png';
  static const String onboarding2 = 'assets/images/onboarding2.png';
  static const String onboarding3 = 'assets/images/onboarding3.png';
  // social media icons
  static const String facebook = 'assets/icons/facebook.png';
  static const String google = 'assets/icons/google.png';
  static const String doctor = 'assets/icons/Doctors.png';
  static const String favorite = 'assets/icons/favorite.png';
  static const String pharmacy = 'assets/icons/Pharmacy.png';
  static const String record = 'assets/icons/record.png';
  static const String specialties = 'assets/icons/Specialties.png';
}
