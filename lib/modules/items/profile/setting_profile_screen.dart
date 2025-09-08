import 'package:flutter/material.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class SettingProfileScreen extends StatelessWidget {
  const SettingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
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
          trailing: Icon(Icons.arrow_forward_ios, size: 18),
          onTap: item['onTap'],
        );
      }).toList(),
    );
  }
}
