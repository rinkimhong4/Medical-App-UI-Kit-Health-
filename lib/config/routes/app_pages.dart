import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/modules/auth/signin/sing_in_screen.dart';
import 'package:medical_app/modules/auth/signup/sing_up_screen.dart';
import 'package:medical_app/modules/screen/view/start_screen/onboarding_page.dart';
import 'package:medical_app/modules/screen/view/start_screen/splash_screen.dart';
import 'package:medical_app/widgets/main_navigation_screen.dart';

class AppRouting {
  static final route = RouteView.values.map((e) {
    switch (e) {
      case RouteView.home:
        return GetPage(
          name: "/",
          // page: () => HomeResponsive(),
          page: () => MainNavigationScreen(),
          transition: Transition.noTransition,
        );
      case RouteView.splash:
        return GetPage(
          name: "/${e.name}",
          page: () => SplashScreen(),
          // binding: SplashBinding(),
        );
      case RouteView.onboarding:
        return GetPage(
          name: "/${e.name}",
          page: () => OnboardingPage1(),
          // binding: OnboardingBinding(),
        );
      case RouteView.signin:
        return GetPage(
          name: "/${e.name}",
          page: () => SignInScreen(),
          // binding: OnboardingBinding(),
        );
      case RouteView.signup:
        return GetPage(
          name: "/${e.name}",
          page: () => SignUpScreen(),
          // binding: OnboardingBinding(),
        );
      case RouteView.forgotPassword:
        return GetPage(
          name: "/${e.name}",
          page: () => ForgotPasswordScreen(),
          // binding: OnboardingBinding(),
        );
      case RouteView.verifyEmail:
        return GetPage(
          name: "/${e.name}",
          page: () => VerifyEmailScreen(),
          // binding: OnboardingBinding(),
        );
    }
  }).toList();
}
