import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ImageInfo;
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/home/home_controller.dart';
import 'package:medical_app/widgets/hero_layout_card_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controllerInstance = Get.put(HomeController());
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
          return [
            CupertinoSliverNavigationBar(
              border: null,
              backgroundColor: AppColors.white,
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: CachedNetworkImageProvider(
                  'https://www.catholicsingles.com/wp-content/uploads/2020/06/blog-header-3.png',
                ),
              ),
              largeTitle: Text(
                'Kimhong',
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
      children: [TopBannerScreen(), _buildSpecialty],
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
}
