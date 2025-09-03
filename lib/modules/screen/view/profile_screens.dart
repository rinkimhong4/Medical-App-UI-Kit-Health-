import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/modules/screen/controller/auth/auth_controller.dart';
import 'package:medical_app/modules/screen/controller/profile_controller.dart';

class ProfileScreens extends GetView<ProfileController> {
  ProfileScreens({super.key});

  final authController = Get.find<AuthController>();
  final name = 'Dr. Jonh';

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 250;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Icon(Icons.arrow_back_ios),
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
                        name,
                        style: AppTextStyle.bold18(color: AppColors.white),
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primarySwatch,
                            AppTheme.secondarySwatch,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                        opacity: t,
                        child: Column(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Add your top text here
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      'My Profile',
                                      style: AppTextStyle.bold18(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Inside the FlexibleSpaceBar's background Column
                            _buildAvatar,
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(children: [SizedBox(height: 30), buildList()]),
            ),
          ],
        ),
      ),
    );
  }

  get _buildAvatar {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Stack(
          children: [
            // avatar
            CircleAvatar(
              radius: 70,
              backgroundImage: CachedNetworkImageProvider(
                'https://www.future-doctor.de/wp-content/uploads/2024/08/shutterstock_2480850611.jpg',
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.black),
              ),
            ),
          ],
        ),

        // User Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: AppTextStyle.bold20()),
            Text(
              '+123 567 89000',
              style: AppTextStyle.regular14(color: AppColors.white),
            ),
            Text(
              'Janedoe@example.com',
              style: AppTextStyle.regular14(color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }

  buildList() {
    return Obx(() {
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      // ProfileBinding
      final listTitleModels = controller.listTitleModels;
      return Column(
        children: List.generate(listTitleModels.length, (index) {
          final item = listTitleModels[index];
          return BuildListTitle(
            title: item.title ?? '',
            iconLeading: item.iconLeading!,
            iconAction: item.iconAction!,
          );
        }),
      );
    });
  }
}

class BuildListTitle extends StatelessWidget {
  final String title;
  final IconData iconLeading;
  final VoidCallback? onTap;
  final IconData iconAction;
  const BuildListTitle({
    super.key,
    required this.title,
    required this.iconAction,
    required this.iconLeading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primarySwatch,
            ),
            child: Icon(iconLeading, color: AppColors.white, size: 24),
          ),
          title: Text(
            title,
            style: AppTextStyle.bold14(color: AppColors.black),
          ),
          trailing: Icon(iconAction),
        ),
      ],
    );
  }
}
// Center(
//         child: LogOutButton(
//           text: "Sign Out",
//           onPressed: () => authController.signOut(),
//         ),
//       ),