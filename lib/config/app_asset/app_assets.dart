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

class AppAssets {
  static const String logo = 'assets/logo/logo.png';
  static const String logo2 = 'https://example.com/pic.png';
  static const String logo3 = 'assets/icons/icon.svg';
  static const String logo4 = 'https://example.com/icon.svg';
  //  usage AppImage(AppAssets.logo, width: 100, height: 100),
}
