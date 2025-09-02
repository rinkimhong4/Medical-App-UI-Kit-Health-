import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/home/home_controller.dart';

class SpecialtiesScreen extends GetView<HomeController> {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 170;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: expandedHeight,
              backgroundColor: AppTheme.primarySwatch,
              elevation: 5,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final maxHeight = constraints.maxHeight;
                  final minHeight =
                      kToolbarHeight + MediaQuery.of(context).padding.top;

                  // Scroll factor: 0 = fully collapsed, 1 = fully expanded
                  final t =
                      ((maxHeight - minHeight) / (expandedHeight - minHeight))
                          .clamp(0.0, 1.0);

                  // Title vertical position: moves smoothly from bottom to center
                  final titleOffset = 25 * t;

                  return FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    titlePadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    title: Transform.translate(
                      offset: Offset(0, titleOffset),
                      child: Text(
                        'Specialties',
                        style: AppTextStyle.bold18(color: AppColors.white),
                      ),
                    ),
                    background: Container(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                        opacity: t, // fade the search area
                        child: Column(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Add your top text here
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      'Specialties',
                                      style: AppTextStyle.bold18(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      'Find Your Doctor',
                                      style: AppTextStyle.regular12(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Inside the FlexibleSpaceBar's background Column
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                              child: TextFormField(
                                style: AppTextStyle.regular14(
                                  color: AppColors.black,
                                ),
                                cursorColor: AppTheme.primarySwatch,
                                decoration: InputDecoration(
                                  hintText: 'Search specialties...',
                                  hintStyle: AppTextStyle.regular14(
                                    color: AppColors.grey,
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppAssets.search,
                                      color: AppTheme.primarySwatch,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.primarySwatch.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.primarySwatch.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.primarySwatch,
                                      width: 1.5,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(child: _buildSpecialty),
          ],
        ),
      ),
    );
  }

  get _buildSpecialty => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = controller.homeModelList;
          if (items.isEmpty) return CircularProgressIndicator();

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
