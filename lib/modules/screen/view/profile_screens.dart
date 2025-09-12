import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/items/profile/privacy_policy_items.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(child: _buildCustomScrollView()),
    );
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(slivers: [_buildAppBar, _buildBody]);
  }

  SliverAppBar get _buildAppBar {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      // pinned: true,
      // floating: false,
      centerTitle: true,
      title: Text(
        "Profile",
        style: AppTextStyle.bold16(color: AppColors.black),
      ),
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back, color: AppColors.black),
      //   onPressed: () => Get.back(),
      // ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: AppColors.black),
          onPressed: () {
            RouteView.settingProfileScreen.go();
          },
        ),
      ],
    );
  }

  get _buildBody => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader,
            SizedBox(height: 20),
            _buildListTitle,
            SizedBox(height: 20),
          ],
        );
      }),
    ),
  );

  Widget get _buildListTitle {
    // List of menu items with onTap actions
    List<Map<String, dynamic>> listData = [
      {
        'title': 'Profile',
        'icon': AppAssets.profileOutline,
        'onTap': () {
          RouteView.editprofile.go();
        },
      },
      {
        'title': 'Favorite',
        'icon': AppAssets.favorite,
        'onTap': () {
          // print('Navigate to Favorite');
        },
      },
      {
        'title': 'Payment Method',
        'icon': AppAssets.payment,
        'onTap': () {
          // print('Navigate to Payment Method');
        },
      },
      {
        'title': 'Privacy Policy',
        'icon': AppAssets.lock,
        'onTap': () {
          Get.to(() => PrivacyPolicyItems());
        },
      },
      {
        'title': 'Settings',
        'icon': AppAssets.setting,
        'onTap': () {
          // print('Navigate to Settings');
        },
      },
      {
        'title': 'Help Center',
        'icon': AppAssets.help,
        'onTap': () {
          RouteView.helpCenterItems.go();
        },
      },
      {
        'title': 'Logout',
        'icon': AppAssets.logout,
        'onTap': () {
          showModalBottomSheet(
            context: Get.context!,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Confirm Logout',
                      style: AppTextStyle.bold16(color: AppColors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Are you sure you want to logout?',
                      style: AppTextStyle.medium18(color: AppColors.black),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // No button with gradient
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.3,
                              color: AppTheme.primarySwatch,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () => Navigator.of(context).pop(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 40,
                                ),
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Yes button with gradient
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppTheme.secondarySwatch,
                                AppTheme.primarySwatch,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Navigator.of(context).pop();
                                authController.signOut();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 40,
                                ),
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      },
    ];

    return Column(
      children: listData.map((item) {
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.secondarySwatch[400]!,
                  AppTheme.primarySwatch[500]!,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Image.asset(item['icon'], color: AppColors.white),
          ),
          title: Text(
            item['title'],
            style: AppTextStyle.regular14(color: AppColors.black),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppTheme.primarySwatch,
          ),
          onTap: item['onTap'],
        );
      }).toList(),
    );
  }

  get _buildProfileHeader {
    final user = authController.currentUser;
    final username = profileController.username.value.isNotEmpty
        ? profileController.username.value
        : (user?.email?.split('@')[0] ?? 'Guest');

    final email = profileController.email.value.isNotEmpty
        ? profileController.email.value
        : (user?.email ?? 'guest@gmail.com');

    final imagePath = profileController.profileImageUrl.value;
    final isNetwork = imagePath.startsWith('http');

    Widget profileImageWidget;

    if (profileController.isLoading.value) {
      profileImageWidget = CircleAvatar(
        radius: 56,
        backgroundColor: Theme.of(context).cardColor,
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (imagePath.isNotEmpty) {
      if (isNetwork) {
        profileImageWidget = CircleAvatar(
          radius: 60,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 58,
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: NetworkImage(imagePath),
            onBackgroundImageError: (_, __) =>
                debugPrint("Network image error"),
          ),
        );
      } else {
        final file = File(imagePath);
        profileImageWidget = file.existsSync()
            ? CircleAvatar(
                radius: 56,
                backgroundColor: Theme.of(context).cardColor,
                backgroundImage: FileImage(file),
              )
            : CircleAvatar(
                radius: 56,
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(
                  Icons.person,
                  size: 56,
                  color: Theme.of(context).hintColor,
                ),
              );
      }
    } else {
      profileImageWidget = CircleAvatar(
        radius: 56,
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(Icons.person, size: 56, color: Theme.of(context).hintColor),
      );
    }

    ///
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            profileImageWidget,
            Positioned(
              bottom: 0,
              right: 0,
              top: 75,
              child: GestureDetector(
                onTap: () async {
                  final userId = authController.currentUser?.id;
                  if (userId != null) {
                    await profileController.uploadProfileImage(userId);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please log in to upload an image.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primarySwatch,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username[0].toUpperCase() + username.substring(1),
                style:
                    Theme.of(context).textTheme.titleSmall?.copyWith(
                      color:
                          Theme.of(context).textTheme.titleSmall?.color ??
                          Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ) ??
                    TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.white,
                    ),
              ),
              SizedBox(height: 8),
              Text(
                email,
                style:
                    Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                    ) ??
                    TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
