import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';

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
