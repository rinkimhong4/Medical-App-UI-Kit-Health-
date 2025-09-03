import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/home/home_controller.dart';
import 'package:medical_app/modules/screen/models/top_banner_models.dart';

class TopBannerScreen extends StatefulWidget {
  const TopBannerScreen({super.key});

  @override
  State<TopBannerScreen> createState() => _TopBannerScreenState();
}

class _TopBannerScreenState extends State<TopBannerScreen> {
  final CarouselController controller = CarouselController(initialItem: 1);
  final HomeController homeController = Get.find<HomeController>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Main carousel using HomeController banners
        Obx(() {
          if (homeController.loadingBanners.value) {
            return SizedBox(
              height: height * 0.27,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height * 0.27),
            child: CarouselView.weighted(
              controller: controller,
              itemSnapping: true,
              flexWeights: const <int>[1, 7, 1],
              children: homeController.banners
                  .map((banner) => HeroLayoutCard(banner: banner))
                  .toList(),
            ),
          );
        }),

        const SizedBox(height: 20),
        // Mini carousel (categories)
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: AppTextStyle.bold16(color: AppColors.black),
              ),
              GestureDetector(
                onTap: () => RouteView.categoriesScreen.go(),
                child: Text(
                  'See all',
                  style: AppTextStyle.regular12(color: AppTheme.primarySwatch),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (homeController.loadingCategories.value) {
            return SizedBox(
              height: 70,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Container(
            height: 70,
            width: width,
            decoration: const BoxDecoration(color: Colors.transparent),
            clipBehavior: Clip.none,
            child: CarouselView.weighted(
              flexWeights: const <int>[2, 3, 3, 3, 2],
              consumeMaxWeight: false,
              children: homeController.categories.map((category) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondarySwatch.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            category.assetPath,
                            color: AppTheme.primarySwatch[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            category.title,
                            style: AppTextStyle.bold12(
                              color: AppTheme.primarySwatch[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width * 0.98,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(banner.url),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Left side text
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    banner.title,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    banner.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    banner.subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Right side thumbnail
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 0.55,
                  child: CachedNetworkImage(
                    imageUrl: banner.thumbUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey[600],
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.medical_services,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
