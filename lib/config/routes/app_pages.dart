import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/modules/auth/signin/sing_in_screen.dart';
import 'package:medical_app/modules/auth/signup/sing_up_screen.dart';
import 'package:medical_app/modules/items/Categories/categories_screen.dart';
import 'package:medical_app/modules/items/Specialties/specialties_items.dart';
import 'package:medical_app/modules/items/Specialties/specialties_screen.dart';
import 'package:medical_app/modules/items/favorite_screen_items.dart';
import 'package:medical_app/modules/items/profile/change_pwd.dart';
import 'package:medical_app/modules/items/profile/edit_profile_screen.dart';
import 'package:medical_app/modules/items/profile/help_center_items.dart';
import 'package:medical_app/modules/items/profile/setting_profile_screen.dart';
import 'package:medical_app/modules/items/rating_screen_items.dart';
import 'package:medical_app/modules/screen/binding/home_binding.dart';
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
          binding: HomeBinding(),
          transition: Transition.noTransition,
        );
      case RouteView.splash:
        return GetPage(
          name: "/${e.name}",
          page: () => SplashScreen(),
          // binding: SplashBinding(),
        );
      case RouteView.settingProfileScreen:
        return GetPage(
          name: "/${e.name}",
          page: () => SettingProfileScreen(),
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
      case RouteView.chnagePwd:
        return GetPage(
          name: "/${e.name}",
          page: () => ChangePasswordScreen(),
          // binding: OnboardingBinding(),
        );
      case RouteView.editprofile:
        return GetPage(
          name: "/${e.name}",
          page: () => EditProfileScreen(),
          // binding: OnboardingBinding(),
        );
      case RouteView.specialtiesScreen:
        return GetPage(
          name: "/${e.name}",
          page: () => SpecialtiesScreen(),
          // binding: OnboardingBinding(),
        );
      case RouteView.specialtiesItems:
        return GetPage(
          name: "/${e.name}",
          page: () => SpecialtiesItems(),
          // binding: OnboardingBinding(),
        );
      case RouteView.categoriesScreen:
        return GetPage(
          name: "/${e.name}",
          page: () => CategoriesScreen(),

          // binding: OnboardingBinding(),
        );
      case RouteView.notificationSettingScreen:
        return GetPage(
          name: "/${e.name}",
          page: () => NotificationSettingScreen(),

          // binding: OnboardingBinding(),
        );
      case RouteView.helpCenterItems:
        return GetPage(
          name: "/${e.name}",
          page: () => HelpCenterItems(),
          // binding: OnboardingBinding(),
        );
      case RouteView.ratingScreenItems:
        return GetPage(
          name: "/${e.name}",
          page: () => RatingScreenItems(),
          // binding: OnboardingBinding(),
        );
      case RouteView.favoriteScreenItems:
        return GetPage(
          name: "/${e.name}",
          page: () => FavoriteScreenItems(),
          // binding: OnboardingBinding(),
        );
    }
  }).toList();
}
