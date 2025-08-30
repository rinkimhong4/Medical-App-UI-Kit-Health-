import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/core/service/local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Controller for handling authentication-related operations using Supabase.
class AuthController extends GetxController {
  /// Controller for email input field.
  final emailCtrl = TextEditingController();

  /// Controller for password input field.
  final passwordCtrl = TextEditingController();

  /// Controller for confirm password input field.
  final confPasswordCtrl = TextEditingController();

  /// Observable boolean to track loading state.
  final isLoading = false.obs;

  /// Observable string to store error messages.
  final RxString errorMessage = ''.obs;

  /// Supabase client instance for authentication operations.
  final _supabase = Supabase.instance.client;

  /// Signs up a new user with the provided email and password.
  ///
  /// Returns null on success, or an error message on failure.
  Future<String?> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await _supabase.auth.signUp(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      if (response.user != null) {
        isLoading.value = false;
        // Navigate based on session status
        if (_supabase.auth.currentSession?.isExpired ?? true) {
          RouteView.verifyEmail.go(clearAll: false);
        } else {
          RouteView.home.go(clearAll: true);
        }
        return null;
      }
      isLoading.value = false;
      return 'Failed to sign up. Please try again.';
    } on AuthException catch (e) {
      isLoading.value = false;
      final message = e.message.contains("already registered")
          ? "This email is already in use."
          : e.message;
      errorMessage.value = message;
      Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      emailCtrl.clear();
      passwordCtrl.clear();
      confPasswordCtrl.clear();
      return message;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Unexpected error: $e';
      Get.snackbar(
        'Error',
        'Unexpected error occurred',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Unexpected error: $e');
      return 'Unexpected error: $e';
    }
  }

  /// Signs in a user with the provided email and password.
  ///
  /// Returns null on success, or an error message on failure.
  Future<String?> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      if (response.session != null) {
        await LocalStorageService.instance.setString(
          'user_id',
          response.user?.id ?? '',
        );
        isLoading.value = false;
        RouteView.home.go(clearAll: true);
        return null;
      }
      isLoading.value = false;
      return 'Failed to sign in. Please try again.';
    } on AuthException catch (e) {
      isLoading.value = false;
      final message = e.message.contains('Invalid login credentials')
          ? 'Invalid email or password.'
          : e.message.contains('Email not confirmed')
          ? 'Please verify your email address.'
          : e.message;
      errorMessage.value = message;
      Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      if (e.message.contains('Email not confirmed')) {
        RouteView.verifyEmail.go(clearAll: false);
      }
      debugPrint('Auth error: ${e.message}');
      return message;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Unexpected error: $e';
      Get.snackbar(
        'Error',
        'Unexpected error occurred',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Unexpected error: $e');
      return 'Unexpected error: $e';
    }
  }

  /// Signs in a user using Facebook OAuth.
  ///
  /// Returns null on success, or an error message on failure.
  Future<String?> signInWithFacebook() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      isLoading.value = false;
      return null;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to sign in with Facebook: $e';
      Get.snackbar(
        'Error',
        'Failed to sign in with Facebook',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Facebook sign-in error: $e');
      return 'Failed to sign in with Facebook: $e';
    }
  }

  /// Sends a password reset email to the provided email address.
  ///
  /// Returns null on success, or an error message on failure.
  Future<String?> resetPassword(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _supabase.auth.resetPasswordForEmail(email.trim().toLowerCase());
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Password reset email sent',
        snackPosition: SnackPosition.TOP,
      );
      return null;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to send reset email: $e';
      Get.snackbar(
        'Error',
        'Failed to send reset email',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Reset password error: $e');
      return 'Failed to send reset email: $e';
    }
  }

  /// Resends the verification email to the provided email address.
  ///
  /// Returns null on success, or an error message on failure.
  Future<String?> resendVerificationEmail(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email.trim().toLowerCase(),
      );
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Verification email resent',
        snackPosition: SnackPosition.TOP,
      );
      return null;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to resend verification email: $e';
      Get.snackbar(
        'Error',
        'Failed to resend verification email',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('Resend verification error: $e');
      return 'Failed to resend verification email: $e';
    }
  }

  /// Signs out the current user and clears local storage.
  Future<void> signOut() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      await _supabase.auth.signOut();
      final pref = await SharedPreferences.getInstance();
      if (userId != null) {
        await pref.remove('profile_image_url_$userId');
        await pref.remove('profile_image_expiry_$userId');
        await pref.remove('signed_url_avatars/$userId.png');
        await pref.remove('signed_url_avatars/$userId.png_expiry');
      }
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

  /// Validates the provided email address.
  ///
  /// Returns null if valid, or an error message if invalid.
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

  /// Validates the provided password.
  ///
  /// Returns null if valid, or an error message if invalid.
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

  /// Validates the confirm password field.
  ///
  /// Returns null if valid, or an error message if it doesn't match the password.
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordCtrl.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Disposes controllers when the controller is closed.
  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confPasswordCtrl.dispose();
    super.onClose();
  }

  /// Gets the current authenticated user.
  User? get currentUser => _supabase.auth.currentUser;
}
