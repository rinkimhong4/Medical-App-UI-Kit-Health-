import 'package:flutter/material.dart';
import 'package:medical_app/config/routes/app_pages.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedicalApp',
      theme: AppTheme.lightTheme,
      initialRoute: RouteView.splash.name,
      getPages: AppRouting.route,
    );
  }
}
