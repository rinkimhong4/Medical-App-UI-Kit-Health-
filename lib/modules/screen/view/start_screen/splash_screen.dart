import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/view/start_screen/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      backgroundColor: AppTheme.primarySwatch,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: AppImage(AppAssets.logo1),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const OnboardingPage1(), // ✅ navigate to onboarding
    );
  }
}
