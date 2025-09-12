import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';
import 'package:medical_app/widgets/custom_switch_widget.dart';

class SettingProfileScreen extends StatelessWidget {
  const SettingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primarySwatch,
        title: Text('Settings'),
      ),
      body: _buildBody,
    );
  }

  get _buildBody {
    return Column(children: [_buildListTitle]);
  }

  Widget get _buildListTitle {
    // List of menu items with onTap actions
    List<Map<String, dynamic>> listData = [
      {
        'title': 'notification setting',
        'icon': AppAssets.notification,
        'onTap': () {
          RouteView.notificationSettingScreen.go();
          // RouteView.editprofile.go();
        },
      },
      {
        'title': 'password manager',
        'icon': AppAssets.key,
        'onTap': () {
          RouteView.chnagePwd.go();
        },
      },
      {
        'title': 'delete account',
        'icon': AppAssets.profileOutline,
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
                      'Confirm Delete',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Are you sure you want to delete your account?'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // No button
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
                                  style: AppTextStyle.bold20(
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Yes button
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
                                Get.find<ProfileController>().deleteAccount();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 40,
                                ),
                                child: Text(
                                  'Yes',
                                  style: AppTextStyle.bold20(
                                    color: AppColors.white,
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
              shape: BoxShape.circle,
              color: AppTheme.secondarySwatch,
            ),
            child: Image.asset(
              item['icon'],
              color: AppColors.white,
              width: 24,
              height: 24,
            ),
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
}

///
/// ======================== Notifications Setting
///

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primarySwatch,
        title: Text('Notification Setting'),
      ),
      body: _buildBody,
    );
  }

  get _buildBody {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
      child: Column(children: [_buildSwitch]),
    );
  }

  Widget get _buildSwitch {
    final switches = [
      'General Notification',
      'Sound',
      'Sound Call',
      'Vibrate',
      'Special Offers',
      'Payments',
      'Promo and discount',
      'cashback',
    ];

    return Column(
      children: switches.map((title) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.regular16(color: AppColors.black),
              ),
              AdvanceSwitchFlutter(
                radius: 30,
                thumbRadius: 10,
                storageKey: title.replaceAll(' ', '_').toLowerCase(),
                activeChild: Icon(Icons.check, size: 18, color: Colors.blue),
                inactiveChild: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
