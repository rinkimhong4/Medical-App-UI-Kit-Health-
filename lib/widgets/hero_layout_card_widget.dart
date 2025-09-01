import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class TopBannerScreen extends StatefulWidget {
  const TopBannerScreen({super.key});

  @override
  State<TopBannerScreen> createState() => _TopBannerScreenState();
}

class _TopBannerScreenState extends State<TopBannerScreen> {
  final CarouselController controller = CarouselController(initialItem: 1);

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
        // Main carousel
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height * 0.27),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children: ImageInfo.values
                .map((ImageInfo image) => HeroLayoutCard(imageInfo: image))
                .toList(),
          ),
        ),

        SizedBox(height: 20),
        // Mini carousel (categories)
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: AppTextStyle.bold14(color: AppColors.black),
              ),
              Text(
                'See all',
                style: AppTextStyle.regular12(color: AppTheme.primarySwatch),
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: width,
          decoration: const BoxDecoration(color: Colors.transparent),
          clipBehavior: Clip.none,
          child: CarouselView.weighted(
            flexWeights: const <int>[2, 3, 3, 3, 2],
            consumeMaxWeight: false,
            children: CategoryInfo.categoriesInfo.map((category) {
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
                        // child: Icon(
                        //   category.icon,
                        //   color: AppTheme.primarySwatch[700],
                        // ),
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
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.imageInfo});

  final ImageInfo imageInfo;

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
          image: NetworkImage(imageInfo.url),
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
                    imageInfo.title,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    imageInfo.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    imageInfo.subtitle,
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
                    imageUrl: imageInfo.thumbUrl,
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

/// Updated ImageInfo with real placeholder images

enum ImageInfo {
  image0(
    'Pain Relief',
    'Effective and fast-acting',
    'Paracetamol',
    'https://static.vecteezy.com/system/resources/thumbnails/004/449/782/small_2x/abstract-geometric-medical-cross-shape-medicine-and-science-concept-background-medicine-medical-health-cross-healthcare-decoration-for-flyers-poster-web-banner-and-card-illustration-vector.jpg',
    'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg?semt=ais_hybrid&w=740&q=80',
  ),
  image1(
    'Cold & Flu',
    'Treat symptoms quickly',
    'FluMed',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4kgRAwHBd0aAZCJIH-Wrlz0AzyWaqQAT2KP4EMWP_-5zEB_jClIoedBa9C7jTbjcagPE&usqp=CAU',
    'https://thumbs.dreamstime.com/b/portrait-physician-looking-down-notepad-portrait-physician-looking-down-notepad-overwhelmed-concerns-man-wearing-157193179.jpg',
  ),
  image2(
    'Vitamin Supplements',
    'Boost your immunity',
    'Vitamin C',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHxiXTOjKhZUPadC2WWVcbZ8W119wHEblez6rbOZkjb_E_8NNP-fEwTgjnARN_JpGyv2k&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScEp6IBL--G4_UBnjFpLKT2ujIlOh7yiTU2dHUGI4mr1JiyF8nxgwiRkoHYosiYfwZ7wA&usqp=CAU',
  ),
  image3(
    'Heart Health',
    'Supports cardiovascular wellness',
    'CardioPlus',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS596r59Wm09UV4cbw9x63dPvYmhgAPElUkH4CpkCiFLx7v5CHAcBv4tR0vwZb8hX2byk&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHyQ5_c94LFven5AoiP09RAFZpMxGQUEAVoXhr74MXEXakmIvV0XAt37_eFGAhjwwUwlg&usqp=CAU',
  ),
  image4(
    'Skin Care',
    'Gentle and nourishing',
    'DermaCare Cream',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYVuFczeRNIPisELsT4ZsyAQlP3hUSbXZvHjKdRCMACNVA2HceZI5D6yZ76yTkt7KYgvc&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9YjQ1Y7lE-DetVKtEeAps-5gP5f5UOkFXIiKBmjDiIZiu5m6TyRwxBFjHWD1T-ev5klQ&usqp=CAU',
  ),
  image5(
    'Allergy Relief',
    'Fast-acting antihistamines',
    'AllerStop',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHxiXTOjKhZUPadC2WWVcbZ8W119wHEblez6rbOZkjb_E_8NNP-fEwTgjnARN_JpGyv2k&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOFeHbCl9XvD7fGILY3sHhZw5I4jFC41zdnXVyw1U2AwsWINHkB4790dtIHaTixkwjk5c&usqp=CAU',
  ),
  image6(
    'Digestive Health',
    'Supports healthy digestion',
    'Probiotics',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWH8m03SA3CciLZrV_--Hx8FY_GfS64wH38cU_EVzPDuTqNKqDzQCG-GOqhUx5GCjq4Vc&usqp=CAU',
    'https://img.freepik.com/free-photo/confident-young-female-doctor-medical-robe-with-stethoscope-points-side-holds-question-mark-isolated-white-background-with-copy-space_141793-34400.jpg?semt=ais_hybrid&w=740&q=80',
  );

  const ImageInfo(
    this.title,
    this.subtitle,
    this.name,
    this.url,
    this.thumbUrl,
  );
  final String title;
  final String subtitle;
  final String name;
  final String url;
  final String thumbUrl;
}

class CategoryInfo {
  const CategoryInfo({required this.title, required this.assetPath});
  final String title;
  final String assetPath;

  static const List<CategoryInfo> categoriesInfo = [
    CategoryInfo(title: 'Favorite', assetPath: AppAssets.favorite),
    CategoryInfo(title: 'Doctors', assetPath: AppAssets.doctor),
    CategoryInfo(title: 'Pharmacy', assetPath: AppAssets.pharmacy),
    CategoryInfo(title: 'Specialties', assetPath: AppAssets.specialties),
    CategoryInfo(title: 'Record', assetPath: AppAssets.record),
  ];
}
