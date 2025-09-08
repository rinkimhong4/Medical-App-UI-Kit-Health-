// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/home/home_controller.dart';
import 'package:medical_app/modules/screen/models/models.dart';
import 'package:medical_app/widgets/doctor_card_widget.dart';

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
              return GestureDetector(
                onTap: () {
                  // Navigate to Doctor Details screen on profile tap
                  Get.to(
                    () => DoctorDetailsScreen(
                      name: doc.name ?? '',
                      specialty: doc.specialty ?? '',
                      image: doc.image ?? '',
                    ),
                  );
                },
                child: DoctorCard(
                  imageUrl: doc.image ?? '',
                  name: doc.name ?? '',
                  specialty: doc.specialty ?? '',
                  onInfoTap: () => print("Info tapped for ${doc.name}"),
                  onCalendarTap: () => print("Calendar tapped for ${doc.name}"),
                  onDetailsTap: () => print("Details tapped for ${doc.name}"),
                  onFavoriteTap: () => print("Favorite tapped for ${doc.name}"),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
// =

class DoctorDetailsScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final String image;

  const DoctorDetailsScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Info, Reviews, Schedule
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primarySwatch,
          title: Text(name),
        ),
        body: TabBarView(children: [_buildInfoTab()]),
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(image), radius: 50),
          const SizedBox(height: 16),
          Text(name, style: AppTextStyle.bold20()),
          const SizedBox(height: 8),
          Text(specialty, style: AppTextStyle.regular16()),
          const SizedBox(height: 20),
          Text('About Doctor', style: AppTextStyle.bold16()),
          const SizedBox(height: 10),
          Text(
            'Dr. $name is an experienced $specialty specializing in patient care and medical excellence. You can see their reviews, available schedule, and more information here.',
            style: AppTextStyle.regular14(),
          ),
        ],
      ),
    );
  }
}
