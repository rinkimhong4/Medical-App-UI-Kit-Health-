// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class PrivacyPolicyItems extends StatefulWidget {
  const PrivacyPolicyItems({super.key});

  @override
  State<PrivacyPolicyItems> createState() => _PrivacyPolicyItemsState();
}

class _PrivacyPolicyItemsState extends State<PrivacyPolicyItems> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), _buildBodyContent()],
      ),
    );
  }

  // Custom SliverAppBar
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppTheme.primarySwatch,
      pinned: _pinned,
      snap: _snap,
      floating: _floating,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: AppTextStyle.bold16(color: AppColors.white),
        ),
      ),
    );
  }

  // Scrollable body content
  SliverToBoxAdapter _buildBodyContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last update: 14/08/2024',
              style: AppTextStyle.bold12(color: AppColors.black),
            ),
            SizedBox(height: 16),
            Text(
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam...''',
              style: AppTextStyle.regular14(color: AppColors.black),
            ),
            SizedBox(height: 20),
            Text(
              'Terms & Conditions',
              style: AppTextStyle.regular20(color: AppTheme.primarySwatch),
            ),
            SizedBox(height: 16),
            ...List.generate(6, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  '${index + 1}. Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci.',
                  style: AppTextStyle.regular14(color: AppColors.black),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
    // SliverList(
    //   delegate: SliverChildBuilderDelegate((
    //     BuildContext context,
    //     int index,
    //   ) {
    //     return Container(
    //       color: index.isOdd ? Colors.white : Colors.black12,
    //       height: 100.0,
    //       child: Center(
    //         child: Text('$index', textScaler: const TextScaler.linear(5)),
    //       ),
    //     );
    //   }, childCount: 20),
    // ),
