import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/home/home_controller.dart';
import 'package:medical_app/modules/screen/models/models.dart';

class SpecialtiesItems extends GetView<HomeController> {
  const SpecialtiesItems({super.key});

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 170;

    final String selectedSpecialty = Get.arguments ?? "All";

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        selectedSpecialty,
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
                                      selectedSpecialty,
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
            SliverToBoxAdapter(child: _buildDoctorList(selectedSpecialty)),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorList(String specialty) {
    // Access the reactive doctorsBySpecialty from the controller
    List<Cardiology> doctors = [];
    switch (specialty) {
      case "Cardiology":
        doctors = controller.doctorsBySpecialty.value.cardiology ?? [];
        break;
      case "Dermatology":
        doctors = controller.doctorsBySpecialty.value.dermatology ?? [];
        break;
      case "General medicine":
        doctors = controller.doctorsBySpecialty.value.generalMedicine ?? [];
        break;
      case "Gynecology":
        doctors = controller.doctorsBySpecialty.value.gynecology ?? [];
        break;
      case "Odontology":
        doctors = controller.doctorsBySpecialty.value.odontology ?? [];
        break;
      case "Oncology":
        doctors = controller.doctorsBySpecialty.value.oncology ?? [];
        break;
      case "Ophtamology":
        doctors = controller.doctorsBySpecialty.value.ophtamology ?? [];
        break;
      case "Orthopedics":
        doctors = controller.doctorsBySpecialty.value.orthopedics ?? [];
        break;
      default:
        doctors = [];
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Text(
                    'Sort by',
                    style: AppTextStyle.regular12(color: AppColors.black),
                  ),
                  Container(
                    width: 47,
                    height: 21,
                    decoration: BoxDecoration(
                      color: AppTheme.primarySwatch,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text('A-Z', style: AppTextStyle.bold14()),
                    ),
                  ),
                  Container(
                    width: 47,
                    height: 21,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.primarySwatch,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Filter',
                        style: AppTextStyle.bold14(
                          color: AppTheme.primarySwatch,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'see all',
                style: AppTextStyle.regular12(color: AppTheme.primarySwatch),
              ),
            ],
          ),
          Divider(color: AppTheme.primarySwatch[200], thickness: 1.5),
          Column(
            children: doctors.map((doc) {
              return DoctorCard(
                imageUrl: doc.image ?? '',
                name: doc.name ?? '',
                specialty: doc.specialty ?? '',
                onInfoTap: () => print("Info tapped for ${doc.name}"),
                onCalendarTap: () => print("Calendar tapped for ${doc.name}"),
                onDetailsTap: () => print("Details tapped for ${doc.name}"),
                onFavoriteTap: () => print("Favorite tapped for ${doc.name}"),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialty;
  final VoidCallback? onInfoTap;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onDetailsTap;
  final VoidCallback? onFavoriteTap;

  const DoctorCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.specialty,
    this.onInfoTap,
    this.onCalendarTap,
    this.onDetailsTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.transparent,
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.bold16(color: AppColors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    specialty,
                    style: AppTextStyle.regular14(color: AppColors.black),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onInfoTap,
                        child: Container(
                          height: 21,
                          width: 47,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.primarySwatch,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Info',
                              style: AppTextStyle.bold12(
                                color: AppTheme.primarySwatch,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.calendar_month,
                              color: AppTheme.primarySwatch,
                            ),
                            onPressed: onCalendarTap,
                            splashRadius: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.info,
                              color: AppTheme.primarySwatch,
                            ),
                            onPressed: onDetailsTap,
                            splashRadius: 20,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: AppTheme.primarySwatch,
                            ),
                            onPressed: onFavoriteTap,
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
