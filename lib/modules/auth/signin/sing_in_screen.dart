import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final controller = Get.find<AuthController>();
  final _formKeyLogin = GlobalKey<FormState>();
  bool pwdVisibility = false;
  bool isScrolled = false;
  String? _serverError;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final isScrolledDown = scrollController.offset > 10;
      if (isScrolledDown != isScrolled) {
        setState(() => isScrolled = isScrolledDown);
      }
    });
  }

  Color get appBarColor =>
      isScrolled ? AppTheme.primarySwatch : AppTheme.primarySwatch;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Sign In",
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
          backgroundColor: appBarColor,
          elevation: isScrolled ? 5 : 0,
          centerTitle: true,
        ),
        backgroundColor: AppColors.background,
        body: _buildBody,
      ),
    );
  }

  Widget get _buildBody {
    List<Map<String, dynamic>> socialMediaLogins = [
      {"icon": AppAssets.facebook, "label": "Continue with Facebook"},
      {"icon": AppAssets.google, "label": "Continue with Email"},
    ];
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        width: Get.width,
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Welcome Back!",
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.primarySwatch[700],
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Login to your account to continue shopping and manage your orders.",
                style: AppTextStyle.regular12(),
              ),
              SizedBox(height: 50),
              Form(
                key: _formKeyLogin,
                child: Focus(
                  child: Builder(
                    builder: (context) {
                      final hasFocus = Focus.of(context).hasFocus;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: AppTextStyle.battamBong20(
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            controller: controller.emailCtrl,
                            decoration: InputDecoration(
                              hintText: "example@example.com",
                              hintStyle: AppTextStyle.battamBong16(
                                color: AppColors.blackGrey,
                              ),
                              labelStyle: TextStyle(
                                color: hasFocus
                                    ? AppColors.black
                                    : AppColors.blackGrey,
                              ),
                              fillColor: AppColors.backgroundText,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.cardShadow.withValues(),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.darkColorLight,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            validator: controller.validateEmail,
                            style: const TextStyle(
                              color: AppColors.darkColorLight,
                            ),
                            onChanged: (value) {
                              if (_serverError != null) {
                                setState(() => _serverError = null);
                                _formKeyLogin.currentState!.validate();
                              }
                            },
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Password',
                            style: AppTextStyle.battamBong20(
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            obscuringCharacter: '*',
                            autocorrect: false,
                            controller: controller.passwordCtrl,
                            obscureText: !pwdVisibility,
                            decoration: InputDecoration(
                              hintText: "***************",
                              hintStyle: AppTextStyle.battamBong16(
                                color: AppColors.blackGrey,
                              ),
                              labelStyle: TextStyle(
                                color: hasFocus
                                    ? AppColors.black
                                    : AppColors.blackGrey,
                              ),
                              fillColor: AppColors.backgroundText,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.cardShadow.withValues(),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.darkColorLight,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: InkWell(
                                  onTap: () => setState(
                                    () => pwdVisibility = !pwdVisibility,
                                  ),
                                  child: Icon(
                                    pwdVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: hasFocus
                                        ? AppColors.darkColorLight
                                        : AppColors.blackGrey,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              final clientError = controller.validatePassword(
                                value,
                              );
                              if (clientError != null) return clientError;
                              if (_serverError != null) return _serverError;
                              return null;
                            },
                            style: const TextStyle(
                              color: AppColors.darkColorLight,
                            ),
                            onChanged: (value) {
                              if (_serverError != null) {
                                setState(() => _serverError = null);
                                _formKeyLogin.currentState!.validate();
                              }
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                RouteView.forgotPassword.go(clearAll: false);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(color: AppColors.darkColorLight),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 52,
                              child: Obx(
                                () => GestureDetector(
                                  onTap: controller.isLoading.value
                                      ? null
                                      : () async {
                                          setState(() => _serverError = null);
                                          if (_formKeyLogin.currentState!
                                              .validate()) {
                                            final error = await controller
                                                .signIn(
                                                  controller.emailCtrl.text
                                                      .trim(),
                                                  controller.passwordCtrl.text,
                                                );
                                            if (error != null) {
                                              setState(
                                                () => _serverError = error,
                                              );
                                              _formKeyLogin.currentState!
                                                  .validate();
                                            } else {
                                              controller.emailCtrl.clear();
                                              controller.passwordCtrl.clear();
                                            }
                                          }
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppTheme.primarySwatch,
                                          AppTheme.secondarySwatch,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Center(
                                      child: controller.isLoading.value
                                          ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.white,
                                              ),
                                            )
                                          : Text(
                                              'Sign In',
                                              style: AppTextStyle.bold18(
                                                color: AppColors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 1,
                                  color: AppColors.blackGrey,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    "or Login with",
                                    style: AppTextStyle.regular12(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  height: 1,
                                  color: AppColors.blackGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: socialMediaLogins.map((social) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      overlayColor: AppColors.darkColorLight
                                          .withValues(alpha: 0.1),
                                      elevation: 0,
                                      backgroundColor: AppTheme.primarySwatch,
                                      side: BorderSide(
                                        color: AppTheme.secondarySwatch
                                            .withValues(alpha: 0.6),
                                        width: 1,
                                      ),
                                      shape: CircleBorder(),
                                      fixedSize: Size(44, 44),
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () async {
                                      if (social['label'] ==
                                          'Continue with Facebook') {
                                        await controller.signInWithFacebook();
                                      }
                                    },
                                    child: Image.asset(
                                      social['icon'],
                                      width: 24,
                                      height: 24,
                                      color: AppColors.white,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: AppTextStyle.regular13(),
                              ),
                              SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  controller.emailCtrl.clear();
                                  controller.passwordCtrl.clear();
                                  RouteView.signup.go(clearAll: true);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: AppTextStyle.regular14(
                                    color: AppTheme.primarySwatch,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ============

/// Screen for sending password reset links.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  bool isScrolled = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_handleScroll);
  }

  /// Handles scroll events to update AppBar appearance.
  void _handleScroll() {
    final isScrolledDown = scrollController.offset > 10;
    if (isScrolledDown != isScrolled) {
      setState(() => isScrolled = isScrolledDown);
    }
  }

  /// Gets the AppBar background color based on scroll state.
  Color get appBarColor =>
      isScrolled ? AppColors.darkColorLight : AppColors.background;

  @override
  void dispose() {
    emailCtrl.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.darkColorLight),
            onPressed: () => Get.back(),
          ),
          title: isScrolled
              ? Text(
                  'Reset Password',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppColors.darkColorLight,
                  ),
                )
              : null,
          backgroundColor: appBarColor,
          elevation: isScrolled ? 5 : 0,
          centerTitle: true,
        ),
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: Get.width,
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Your Password',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppColors.darkColorLight,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email to receive a password reset link.',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppColors.blackGrey,
                  ),
                ),
                const SizedBox(height: 58),
                Form(
                  key: _formKey,
                  child: Focus(
                    child: Builder(
                      builder: (context) {
                        final hasFocus = Focus.of(context).hasFocus;
                        return Column(
                          children: [
                            TextFormField(
                              autocorrect: false,
                              controller: emailCtrl,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle: AppTheme
                                    .lightTheme
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.blackGrey),
                                labelStyle: TextStyle(
                                  color: hasFocus
                                      ? AppColors.darkColorLight
                                      : AppColors.blackGrey,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: hasFocus
                                      ? AppColors.darkColorLight
                                      : AppColors.blackGrey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(
                                    color: AppColors.darkColorLight.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(
                                    color: AppColors.darkColorLight,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                              validator: controller.validateEmail,
                              style: const TextStyle(
                                color: AppColors.darkColorLight,
                              ),
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              width: Get.width,
                              height: 52,
                              child: Obx(
                                () => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColors.darkColorLight,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    overlayColor: AppColors.darkColorLight
                                        .withValues(alpha: 0.1),
                                    foregroundColor: controller.isLoading.value
                                        ? AppColors.darkColorLight.withValues(
                                            alpha: 0.5,
                                          )
                                        : AppColors.darkColorLight,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.resetPassword(
                                        emailCtrl.text.trim(),
                                      );
                                      emailCtrl.clear();
                                    }
                                  },
                                  child: controller.isLoading.value
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : Text(
                                          'Send Reset Link',
                                          style: AppTheme
                                              .lightTheme
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppColors.white,
                                              ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Remembered your password?',
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: AppColors.blackGrey),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    emailCtrl.clear();
                                    RouteView.signin.go(clearAll: true);
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: AppColors.darkColorLight,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
