import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
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
      // case RouteView.notification:
      //   return GetPage(
      //     name: "/${e.name}",
      //     page: () => NotificationScreen(),
      //     binding: NotificationBinding(),
      //   );
    }
  }).toList();
}
