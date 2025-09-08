import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
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
        'icon': Icons.person,
        'onTap': () {
          RouteView.editprofile.go();
        },
      },
      {
        'title': 'Favorite',
        'icon': Icons.favorite,
        'onTap': () {
          // print('Navigate to Favorite');
        },
      },
      {
        'title': 'Payment Method',
        'icon': Icons.payment,
        'onTap': () {
          // print('Navigate to Payment Method');
        },
      },
      {
        'title': 'Privacy Policy',
        'icon': Icons.lock,
        'onTap': () {
          // print('Navigate to Privacy Policy');
        },
      },
      {
        'title': 'Settings',
        'icon': Icons.settings,
        'onTap': () {
          // print('Navigate to Settings');
        },
      },
      {
        'title': 'Help',
        'icon': Icons.help,
        'onTap': () {
          // print('Navigate to Help');
        },
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'onTap': () {
          // Show confirmation dialog
          showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
              title: Text('Confirm Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    authController.signOut();
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
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
              shape: BoxShape.circle,
              color: AppTheme.secondarySwatch,
            ),
            child: Icon(item['icon'], color: Colors.white),
          ),
          title: Text(
            item['title'],
            style: AppTextStyle.regular14(color: AppColors.black),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 18),
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
                    color: Theme.of(context).primaryColor,
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
