import 'package:flutter/material.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class CustomBottomNavBar extends StatelessWidget {
  final void Function(int)? onTap;
  final int selectedIndex;

  const CustomBottomNavBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Widget>> iconList = [
      {
        'active': AppImage(AppAssets.homeFill),
        'inactive': AppImage(AppAssets.homeOutline),
      },
      {
        'active': AppImage(AppAssets.messageFill),
        'inactive': AppImage(AppAssets.messageOutline),
      },
      {
        'active': AppImage(AppAssets.profileFill),
        'inactive': AppImage(AppAssets.profileOutline),
      },
      {
        'active': AppImage(AppAssets.bookingFill),
        'inactive': AppImage(AppAssets.bookingOutline),
      },
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.primarySwatch[50],
        // Optional gradient example:
        // gradient: LinearGradient(
        //   colors: [AppTheme.primarySwatch.shade200, AppTheme.secondarySwatch.shade200],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(iconList.length, (index) {
              final bool isActive = selectedIndex == index;
              return GestureDetector(
                onTap: () => onTap?.call(index),
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isActive ? AppTheme.primarySwatch : Color(0xFF00BBD3),
                      BlendMode.srcIn,
                    ),
                    child: isActive
                        ? iconList[index]['active']!
                        : iconList[index]['inactive']!,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
