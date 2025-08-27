import 'package:flutter/material.dart';
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
    final List<Map<String, IconData>> iconList = [
      {'active': Icons.home_filled, 'inactive': Icons.home_outlined},
      {'active': Icons.bookmark, 'inactive': Icons.bookmark_border},
      {'active': Icons.notifications, 'inactive': Icons.notifications_none},
      {'active': Icons.person, 'inactive': Icons.person_outline},
    ];

    return Container(
      height: 76,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primarySwatch, AppTheme.secondarySwatch],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(30),
        ),
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
                child: Icon(
                  isActive
                      ? iconList[index]['active']!
                      : iconList[index]['inactive']!,
                  size: 28,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
