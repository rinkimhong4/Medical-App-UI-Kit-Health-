import 'package:flutter/material.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/widgets/custo_switch_widget.dart';

class SettingProfileScreen extends StatelessWidget {
  const SettingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        'icon': Icons.notifications,
        'onTap': () {
          RouteView.notificationSettingScreen.go();
          // RouteView.editprofile.go();
        },
      },
      {
        'title': 'password manager',
        'icon': Icons.key,
        'onTap': () {
          RouteView.chnagePwd.go();
        },
      },
      {
        'title': 'delete account',
        'icon': Icons.person,
        'onTap': () {
          //
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
/// Notifications Setting
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
    List<Map<String, dynamic>> listData = [
      {
        'title': 'General Notification',
        'switch': AdvanceSwitchFlutter(
          radius: 40,
          thumbRadius: 30,
          activeChild: Container(),
          inactiveChild: Container(),
        ),
      },
      {
        'title': 'App Updates',
        'switch': AdvanceSwitchFlutter(
          radius: 40,
          thumbRadius: 30,
          activeChild: Container(),
          inactiveChild: Container(),
        ),
      },
      {
        'title': 'App Updates',
        'switch': AdvanceSwitchFlutter(
          radius: 40,
          thumbRadius: 30,
          activeChild: Container(),
          inactiveChild: Container(),
        ),
      },
      {
        'title': 'App Updates',
        'switch': AdvanceSwitchFlutter(
          radius: 40,
          thumbRadius: 30,
          activeChild: Container(),
          inactiveChild: Container(),
        ),
      },
    ];

    return Column(
      children: listData.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['title'],
                style: AppTextStyle.regular16(color: AppColors.black),
              ),
              item['switch'],
            ],
          ),
        );
      }).toList(),
    );
  }
}
