import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/modules/screen/view/start_screen/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      backgroundColor: AppTheme.primarySwatch,
      onInit: () async {
        debugPrint("Splash init");
      },
      onEnd: () async {
        debugPrint("Splash ended");

        final prefs = await SharedPreferences.getInstance();
        final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;
        final session = Supabase.instance.client.auth.currentSession;

        if (!seenOnboarding) {
          Get.offAll(() => const OnboardingPage1());
        } else {
          if (session != null) {
            RouteView.home.go(clearAll: true);
          } else {
            RouteView.signin.go(clearAll: true);
          }
        }
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset(AppAssets.logo1),
      ),
      nextScreen: const SizedBox(), // Not used because we handle nav in onEnd
    );
  }
}

// ===========
class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkUser();
  }

  void _checkUser() {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      Get.offAllNamed(RouteView.home.go(clearAll: true) as String);
    } else {
      Get.offAllNamed(RouteView.signin.go(clearAll: true) as String);
    }
  }
}
