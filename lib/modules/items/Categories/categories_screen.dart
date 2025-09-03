import 'package:flutter/material.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/widgets/doctor_card_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
            SliverToBoxAdapter(
              child: DoctorCard(
                imageUrl:
                    'https://www.future-doctor.de/wp-content/uploads/2024/08/shutterstock_2480850611.jpg',
                name: 'Dr. Jonh',
                specialty: 'Teach',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
