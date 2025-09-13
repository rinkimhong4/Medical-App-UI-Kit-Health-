import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/widgets/doctor_card_widget.dart';

class RatingScreenItems extends StatelessWidget {
  const RatingScreenItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [_buildGradientSliverAppBar(), _buildDoctorList()],
      ),
    );
  }

  /// ------------------------------
  /// Gradient SliverAppBar
  /// ------------------------------
  Widget _buildGradientSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("Rating"),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primarySwatch, AppTheme.secondarySwatch],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  /// ------------------------------
  /// Doctor Card List
  /// ------------------------------
  Widget _buildDoctorList() {
    // Example doctor data with all taps inside the list
    final List<Map<String, dynamic>> listDoctorRate = [
      {
        'imageUrl':
            'https://img.freepik.com/free-photo/portrait-young-female-doctor_23-2148827698.jpg',
        'name': 'Dr. John Dev',
        'specialty': 'Dermatologist',
        'onInfoTap': () => print("Info tapped for Dr. John Dev"),
        'onCalendarTap': () => print("Calendar tapped for Dr. John Dev"),
        'onDetailsTap': () => print("Details tapped for Dr. John Dev"),
        'onFavoriteTap': () => print("Favorite tapped for Dr. John Dev"),
      },
      {
        'imageUrl':
            'https://img.freepik.com/free-photo/portrait-young-male-doctor_23-2148827689.jpg',
        'name': 'Dr. Alex Kim',
        'specialty': 'Cardiologist',
        'onInfoTap': () => print("Info tapped for Dr. Alex Kim"),
        'onCalendarTap': () => print("Calendar tapped for Dr. Alex Kim"),
        'onDetailsTap': () => print("Details tapped for Dr. Alex Kim"),
        'onFavoriteTap': () => print("Favorite tapped for Dr. Alex Kim"),
      },
      {
        'imageUrl':
            'https://img.freepik.com/free-photo/portrait-young-female-nurse_23-2148827700.jpg',
        'name': 'Dr. Sophia Lee',
        'specialty': 'Pediatrician',
        'onInfoTap': () => print("Info tapped for Dr. Sophia Lee"),
        'onCalendarTap': () => print("Calendar tapped for Dr. Sophia Lee"),
        'onDetailsTap': () => print("Details tapped for Dr. Sophia Lee"),
        'onFavoriteTap': () => print("Favorite tapped for Dr. Sophia Lee"),
      },
      {
        'imageUrl':
            'https://img.freepik.com/free-photo/portrait-smiling-doctor_23-2147896262.jpg',
        'name': 'Dr. Michael Chen',
        'specialty': 'Neurologist',
        'onInfoTap': () => print("Info tapped for Dr. Michael Chen"),
        'onCalendarTap': () => print("Calendar tapped for Dr. Michael Chen"),
        'onDetailsTap': () => print("Details tapped for Dr. Michael Chen"),
        'onFavoriteTap': () => print("Favorite tapped for Dr. Michael Chen"),
      },
      {
        'imageUrl':
            'https://img.freepik.com/free-photo/portrait-happy-young-doctor_23-2147896321.jpg',
        'name': 'Dr. Emily Carter',
        'specialty': 'Oncologist',
        'onInfoTap': () => print("Info tapped for Dr. Emily Carter"),
        'onCalendarTap': () => print("Calendar tapped for Dr. Emily Carter"),
        'onDetailsTap': () => print("Details tapped for Dr. Emily Carter"),
        'onFavoriteTap': () => print("Favorite tapped for Dr. Emily Carter"),
      },
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(listDoctorRate.length, (i) {
            final doctor = listDoctorRate[i];
            return DoctorCard(
              professionalDocIcon: Icons.school,
              professionalDocTitle: 'Professional Doctor',
              imageUrl: doctor['imageUrl'],
              name: doctor['name'],
              specialty: doctor['specialty'],
              onInfoTap: doctor['onInfoTap'],
              onCalendarTap: doctor['onCalendarTap'],
              onDetailsTap: doctor['onDetailsTap'],
              onFavoriteTap: doctor['onFavoriteTap'],
            );
          }),
        ),
      ),
    );
  }
}
