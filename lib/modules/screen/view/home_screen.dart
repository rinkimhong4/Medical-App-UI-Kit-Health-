import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/widgets/hero_layout_card_widget.dart';

// Replace with your HeroLayoutCard and ImageInfo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              border: null,
              backgroundColor: AppColors.white,
              leading: CircleAvatar(
                backgroundColor: AppColors.darkColor,
                child: const Icon(
                  CupertinoIcons.person,
                  color: AppColors.white,
                ),
              ),
              largeTitle: Text(
                'Kimhong',
                style: AppTextStyle.bold35(color: AppColors.black),
              ),
              trailing: Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_outlined, color: AppColors.black, size: 24),
                  Icon(
                    Icons.notifications_outlined,
                    color: AppColors.black,
                    size: 24,
                  ),
                  Icon(
                    Icons.settings_outlined,
                    color: AppColors.black,
                    size: 24,
                  ),
                ],
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildBodyScreen],
        ),
      ),
    );
  }

  get _buildBodyScreen {
    return Column(
      children: [
        TopBannerScreen(),
        // Text(
        //   'Categories',
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: 12),
        // Wrap(
        //   spacing: 10,
        //   runSpacing: 10,
        //   children: List.generate(
        //     6,
        //     (index) => Chip(label: Text('Category $index')),
        //   ),
        // ),
      ],
    );
  }
}
