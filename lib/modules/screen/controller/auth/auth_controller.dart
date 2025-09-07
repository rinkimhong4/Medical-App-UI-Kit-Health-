import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/core/service/local_service.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confPasswordCtrl = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final _supabase = Supabase.instance.client;

  Future<String?> signUp(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _supabase.auth.signUp(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      RouteView.home.go();

      if (response.user != null) {
        // Signup success, go directly to home
        isLoading.value = false;
        RouteView.home.go(clearAll: true);
        return null;
      } else {
        isLoading.value = false;
        return 'Failed to sign up. Please try again.';
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      String message = e.message.contains("already registered")
          ? "This email is already in use."
          : e.message;

      errorMessage.value = message;

      // Clear inputs
      emailCtrl.clear();
      passwordCtrl.clear();
      confPasswordCtrl.clear();

      return message;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Unexpected error: $e');
      return 'Unexpected error: $e';
    }
  }

  Future<String?> signIn(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      if (response.session != null && response.user != null) {
        // Store user ID locally
        await LocalStorageService.instance.setString(
          'user_id',
          response.user!.id,
        );

        // Load profile (profile picture included)
        final profileController = Get.find<ProfileController>();
        await profileController.loadProfile();

        // Ensure loading state is off
        isLoading.value = false;
        errorMessage.value = '';

        // Navigate to home
        RouteView.home.go(clearAll: true);
        return null;
      } else {
        isLoading.value = false;
        return 'Failed to sign in. Please try again.';
      }
    } on AuthException catch (e) {
      isLoading.value = false;
      String message = e.message.contains('Invalid login credentials')
          ? 'Invalid email or password.'
          : e.message;
      errorMessage.value = message;
      debugPrint('Auth error: ${e.message}');
      return message;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Unexpected error: $e';
      debugPrint('Unexpected error: $e');
      return 'Unexpected error: $e';
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.length > 128) {
      return 'Password must not exceed 128 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    if (value.contains(RegExp(r'\s'))) {
      return 'Password must not contain spaces';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordCtrl.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      // final pref = await SharedPreferences.getInstance();

      // Remove user_id but KEEP profile image
      await LocalStorageService.instance.remove('user_id');

      RouteView.signin.go(clearAll: true);
    } catch (e) {
      errorMessage.value = 'Failed to sign out: $e';
      Get.snackbar(
        'Error',
        'Failed to sign out',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Sign out error: $e');
    }
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confPasswordCtrl.dispose();
    super.onClose();
  }

  User? get currentUser => _supabase.auth.currentUser;
}
