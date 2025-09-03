import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_app/app.dart';
import 'package:medical_app/core/service/local_service.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  /// Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageService.instance.init();
  await GetStorage.init();

  /// Load environment variables
  await dotenv.load(fileName: ".env");
  final url = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
  await Supabase.initialize(url: url!, anonKey: anonKey!);

  /// Initialize GetX controllers
  Get.put(AuthController());
  Get.put(ProfileController());
  runApp(const MyApp());
}
