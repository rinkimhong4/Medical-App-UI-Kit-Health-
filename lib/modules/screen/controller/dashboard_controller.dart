import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    final session = Supabase.instance.client.auth.currentSession;

    if (!seenOnboarding) {
      // First run → onboarding
      RouteView.onboarding.go(clearAll: true);
    } else if (session != null) {
      // Already logged in → home
      RouteView.home.go(clearAll: true);
    } else {
      // Not logged in → sign in
      await RouteView.signin.go(clearAll: true);
    }
  }
}
