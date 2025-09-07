import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.find<AuthController>();
  final _formKeySignup = GlobalKey<FormState>();
  bool pwdVisibility = false;
  bool cPwdVisibility = false;
  final ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  String? _serverError;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final isScrolledDown = scrollController.offset > 10;
      if (isScrolledDown != isScrolled) {
        setState(() {
          isScrolled = isScrolledDown;
        });
      }
    });
  }

  Color get appBarColor =>
      isScrolled ? AppTheme.primarySwatch : AppTheme.primarySwatch;
  Color get colorArrowBack => AppColors.white;

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colorArrowBack),
            onPressed: () {
              controller.emailCtrl.clear();
              controller.passwordCtrl.clear();
              controller.confPasswordCtrl.clear();
              RouteView.signin.go(clearAll: true);
            },
          ),
          title: Text(
            "Sign Up",
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
                "Please Sign Up",
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppColors.blackGrey,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Sign up to start shopping and manage your orders.",
                style: AppTextStyle.regular12(),
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKeySignup,
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
                                  color: AppColors.blackGrey,
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
                            validator: (value) {
                              final clientError = controller.validateEmail(
                                value,
                              );
                              if (clientError != null) return clientError;
                              if (_serverError != null) return _serverError;
                              return null;
                            },
                            style: const TextStyle(color: AppColors.blackGrey),
                            onChanged: (value) {
                              if (_serverError != null) {
                                setState(() => _serverError = null);
                                _formKeySignup.currentState!.validate();
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
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.blackGrey,
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
                            validator: controller.validatePassword,
                            style: const TextStyle(color: AppColors.blackGrey),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Password',
                            style: AppTextStyle.battamBong20(
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            controller: controller.confPasswordCtrl,
                            obscureText: !cPwdVisibility,
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
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: InkWell(
                                  onTap: () => setState(
                                    () => cPwdVisibility = !cPwdVisibility,
                                  ),
                                  child: Icon(
                                    cPwdVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: hasFocus
                                        ? AppColors.darkColorLight
                                        : AppColors.blackGrey,
                                  ),
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: BorderSide(
                                  color: AppColors.blackGrey,
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
                            validator: controller.validateConfirmPassword,
                            style: const TextStyle(color: AppColors.blackGrey),
                          ),
                          const SizedBox(height: 50),
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 58,
                              child: Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppTheme.primarySwatch,
                                        AppTheme.secondarySwatch,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors
                                          .transparent, // transparent to show gradient
                                      shadowColor:
                                          Colors.transparent, // remove shadow
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                    ),
                                    onPressed: () async {
                                      setState(() => _serverError = null);
                                      if (_formKeySignup.currentState!
                                          .validate()) {
                                        final error = await controller.signUp(
                                          controller.emailCtrl.text.trim(),
                                          controller.passwordCtrl.text.trim(),
                                        );
                                        if (error != null) {
                                          setState(() => _serverError = error);
                                          _formKeySignup.currentState!
                                              .validate();
                                        } else {
                                          controller.emailCtrl.clear();
                                          controller.passwordCtrl.clear();
                                          controller.confPasswordCtrl.clear();
                                        }
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
                                            'Sign Up',
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
                            ),
                          ),
                          const SizedBox(height: 24),
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
                          const SizedBox(height: 24),
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
                                      // if (social['label'] ==
                                      //     'Continue with Facebook') {
                                      //   await controller.signInWithFacebook();
                                      // }
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
                                "Already have an account?",
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

// ====

/// Screen for resending email verification links.
// class VerifyEmailScreen extends StatefulWidget {
//   const VerifyEmailScreen({super.key});

//   @override
//   State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
// }

// class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
//   final controller = Get.find<AuthController>();
//   final emailCtrl = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool isScrolled = false;
//   final ScrollController scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     emailCtrl.text = controller.emailCtrl.text; // Pre-fill with sign-up email
//     scrollController.addListener(_handleScroll);
//   }

//   /// Handles scroll events to update AppBar appearance.
//   void _handleScroll() {
//     final isScrolledDown = scrollController.offset > 10;
//     if (isScrolledDown != isScrolled) {
//       setState(() => isScrolled = isScrolledDown);
//     }
//   }

//   /// Gets the AppBar background color based on scroll state.
//   Color get appBarColor =>
//       isScrolled ? AppColors.darkColorLight : AppColors.background;

//   @override
//   void dispose() {
//     emailCtrl.dispose();
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios, color: AppColors.darkColorLight),
//             onPressed: () => Get.back(),
//           ),
//           title: isScrolled
//               ? Text(
//                   'Verify Email',
//                   style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
//                     color: AppColors.darkColorLight,
//                   ),
//                 )
//               : null,
//           backgroundColor: appBarColor,
//           elevation: isScrolled ? 5 : 0,
//           centerTitle: true,
//         ),
//         backgroundColor: AppColors.background,
//         body: SingleChildScrollView(
//           controller: scrollController,
//           child: Container(
//             width: Get.width,
//             color: AppColors.background,
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Verify Your Email',
//                   style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
//                     color: AppColors.darkColorLight,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Enter your email to resend the verification link.',
//                   style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
//                     color: AppColors.blackGrey,
//                   ),
//                 ),
//                 const SizedBox(height: 58),
//                 Form(
//                   key: _formKey,
//                   child: Focus(
//                     child: Builder(
//                       builder: (context) {
//                         final hasFocus = Focus.of(context).hasFocus;
//                         return Column(
//                           children: [
//                             TextFormField(
//                               autocorrect: false,
//                               controller: emailCtrl,
//                               decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 hintText: 'Enter your email',
//                                 hintStyle: AppTheme
//                                     .lightTheme
//                                     .textTheme
//                                     .bodyMedium
//                                     ?.copyWith(color: AppColors.blackGrey),
//                                 labelStyle: TextStyle(
//                                   color: hasFocus
//                                       ? AppColors.darkColorLight
//                                       : AppColors.blackGrey,
//                                 ),
//                                 prefixIcon: Icon(
//                                   Icons.email_outlined,
//                                   color: hasFocus
//                                       ? AppColors.darkColorLight
//                                       : AppColors.blackGrey,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(32),
//                                   borderSide: BorderSide(
//                                     color: AppColors.darkColorLight.withValues(
//                                       alpha: 0.6,
//                                     ),
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(32),
//                                   borderSide: BorderSide(
//                                     color: AppColors.darkColorLight,
//                                   ),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Colors.red,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(32),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Colors.red,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(32),
//                                 ),
//                                 errorStyle: const TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               validator: controller.validateEmail,
//                               style: const TextStyle(
//                                 color: AppColors.darkColorLight,
//                               ),
//                             ),
//                             const SizedBox(height: 50),
//                             SizedBox(
//                               width: Get.width,
//                               height: 52,
//                               child: Obx(
//                                 () => ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     elevation: 0,
//                                     backgroundColor: AppColors.darkColorLight,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(32),
//                                     ),
//                                     overlayColor: AppColors.darkColorLight
//                                         .withValues(alpha: 0.1),
//                                     foregroundColor: controller.isLoading.value
//                                         ? AppColors.darkColorLight.withValues(
//                                             alpha: 0.5,
//                                           )
//                                         : AppColors.darkColorLight,
//                                   ),
//                                   onPressed: () async {
//                                     if (_formKey.currentState!.validate()) {
//                                       await controller.resendVerificationEmail(
//                                         emailCtrl.text.trim(),
//                                       );
//                                       emailCtrl.clear();
//                                     }
//                                   },
//                                   child: controller.isLoading.value
//                                       ? const SizedBox(
//                                           width: 20,
//                                           height: 20,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                             color: AppColors.white,
//                                           ),
//                                         )
//                                       : Text(
//                                           'Resend Verification Email',
//                                           style: AppTheme
//                                               .lightTheme
//                                               .textTheme
//                                               .bodyMedium
//                                               ?.copyWith(
//                                                 color: AppColors.white,
//                                               ),
//                                         ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Already verified?',
//                                   style: AppTheme
//                                       .lightTheme
//                                       .textTheme
//                                       .labelSmall
//                                       ?.copyWith(color: AppColors.blackGrey),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 TextButton(
//                                   onPressed: () {
//                                     emailCtrl.clear();
//                                     RouteView.signin.go(clearAll: true);
//                                   },
//                                   child: Text(
//                                     'Sign In',
//                                     style: AppTheme
//                                         .lightTheme
//                                         .textTheme
//                                         .labelSmall
//                                         ?.copyWith(
//                                           color: AppColors.darkColorLight,
//                                         ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
