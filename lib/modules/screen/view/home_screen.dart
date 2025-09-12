import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ImageInfo;
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/core/data/data.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';
import 'package:medical_app/modules/screen/controller/home/home_controller.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';
import 'package:medical_app/modules/screen/models/models.dart';
import 'package:medical_app/widgets/hero_layout_card_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controllerInstance = Get.put(HomeController());
    final authController = Get.find<AuthController>();
    final profileController = Get.find<ProfileController>();
    controllerInstance.loadingData();
    List<Widget> iconsAppBar = [
      Image.asset(AppAssets.search, color: AppColors.black),
      Image.asset(AppAssets.notification, color: AppColors.black),
      Image.asset(AppAssets.setting, color: AppColors.black),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          final user = authController.currentUser;
          final username = profileController.username.value.isNotEmpty
              ? profileController.username.value
              : (user?.email?.split('@')[0] ?? 'Guest');

          final imagePath = profileController.profileImageUrl.value;
          final isNetwork = imagePath.startsWith('http');

          // Use ImageProvider for CircleAvatar
          ImageProvider? avatarImage;
          if (profileController.isLoading.value) {
            avatarImage = null;
          } else if (imagePath.isNotEmpty) {
            avatarImage = isNetwork
                ? NetworkImage(imagePath)
                : File(imagePath).existsSync()
                ? FileImage(File(imagePath))
                : null;
          }

          return [
            CupertinoSliverNavigationBar(
              border: null,
              backgroundColor: AppColors.white,
              leading: profileController.isLoading.value
                  ? CircleAvatar(
                      radius: 24,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : CircleAvatar(
                      radius: 24,
                      backgroundColor: AppTheme.primarySwatch[100],
                      backgroundImage: avatarImage,
                      child: avatarImage == null
                          ? Icon(
                              Icons.person,
                              color: Theme.of(context).hintColor,
                            )
                          : null,
                    ),
              largeTitle: Text(
                username,
                style: AppTextStyle.bold35(color: AppColors.black),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  iconsAppBar.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primarySwatch[50],
                      ),
                      child: Center(child: iconsAppBar[index]),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildBodyScreen(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [TopBannerScreen(), _buildSpecialtyCategory, _buildSpecialty],
    );
  }

  get _buildSpecialty => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Specialties',
              style: AppTextStyle.bold16(color: AppColors.black),
            ),
            GestureDetector(
              onTap: () => RouteView.specialtiesScreen.go(),
              child: Text(
                'See all',
                style: AppTextStyle.regular12(color: AppTheme.primarySwatch),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(child: SizedBox.shrink());
          }
          final items = controller.homeModelList;
          if (items.isEmpty) return SizedBox.shrink();

          final rows = (items.length / 3).ceil();
          return Column(
            children: List.generate(
              rows,
              (rowIndex) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (colIndex) {
                    int index = rowIndex * 3 + colIndex;
                    if (index >= items.length) {
                      return SizedBox(width: 130, height: 130);
                    }
                    final item = items[index];
                    return GestureDetector(
                      onTap: () =>
                          RouteView.specialtiesItems.go(arguments: item.title),
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.primarySwatch[400]!,
                              AppTheme.primarySwatch[500]!,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              item.image ?? '',
                              color: AppColors.white,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title ?? '',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bold14(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }),
      ),
    ],
  );

  Widget get _buildSpecialtyCategory => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: AppTextStyle.bold16(color: AppColors.black),
            ),
            GestureDetector(
              onTap: () => RouteView.categoriesScreen.go(arguments: "All"),
              child: Text(
                'See all',
                style: AppTextStyle.regular12(color: AppTheme.primarySwatch),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),

      // Horizontal scroll
      SizedBox(
        height: 90,
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = controller.doctorsMap.keys.toList();
          if (items.isEmpty) return const SizedBox.shrink();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = items[index];
              final assetPath = Datas.categoryAssets[category];

              return GestureDetector(
                onTap: () => RouteView.categoriesScreen.go(arguments: category),
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primarySwatch[400]!,
                        AppTheme.primarySwatch[500]!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (assetPath != null)
                        Image.asset(
                          assetPath,
                          width: 28,
                          height: 28,
                          color: AppColors.white,
                        )
                      else
                        const Icon(
                          Icons.help_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      const SizedBox(height: 6),
                      Text(
                        category,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bold10(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    ],
  );
}
