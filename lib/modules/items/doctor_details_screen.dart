import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/routes/app_routes.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final String image;
  final String focus;
  final String profile;
  final String careerPath;
  final String highlights;

  const DoctorDetailsScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.image,
    required this.focus,
    required this.profile,
    required this.careerPath,
    required this.highlights,
  });

  static const double expandedHeight = 270;
  @override
  Widget build(BuildContext context) {
    // Your data list with callbacks
    final List<Map<String, dynamic>> rateComment = [
      {
        'value': 5,
        'icon': Icons.star_rate_rounded,
        'onTap': () {
          RouteView.ratingScreenItems.go();
        },
      },
      {'value': 30, 'icon': Icons.message_rounded, 'onTap': () {}},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [_buildSliverAppBar(rateComment, context), _buildContent()],
      ),
    );
  }

  /// ------------------------------
  /// SliverAppBar
  /// ------------------------------
  Widget _buildSliverAppBar(
    List<Map<String, dynamic>> rateComment,
    BuildContext context,
  ) {
    return SliverAppBar(
      toolbarHeight: 72,
      pinned: true,
      expandedHeight: expandedHeight,
      backgroundColor: AppTheme.primarySwatch,
      elevation: 5,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(Icons.arrow_back_ios_new, color: AppColors.white),
      ),
      title: _buildTopRowIcons(),
      centerTitle: false,
      actions: _buildActions(),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
          final t = ((maxHeight - minHeight) / (expandedHeight - minHeight))
              .clamp(0.0, 1.0);
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
            background: _buildFlexibleBackground(t, rateComment),
          );
        },
      ),
    );
  }

  /// Top Row with Schedule and action icons
  Widget _buildTopRowIcons() {
    return Row(
      spacing: 4,
      children: [
        _buildScheduleBox(),
        _buildCircleIconFilled(AppAssets.call),
        _buildCircleIconFilled(AppAssets.chat),
        _buildCircleIconFilled(AppAssets.video),
      ],
    );
  }

  /// Schedule Box Widget
  Widget _buildScheduleBox() {
    return Container(
      height: 28,
      width: 85,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(Icons.calendar_month, size: 14, color: AppTheme.primarySwatch),
          const SizedBox(width: 6),
          ShaderMask(
            shaderCallback: (bounds) => RadialGradient(
              center: Alignment.topRight,
              radius: 4.0,
              colors: [AppTheme.primarySwatch, AppTheme.secondarySwatch[500]!],
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: Text('Schedule', style: GoogleFonts.inter(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  /// Top right actions
  List<Widget> _buildActions() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCircleIconOutline(AppAssets.help),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () => RouteView.favoriteScreenItems.go(),

              child: _buildCircleIconOutline(AppAssets.favorite),
            ),
          ],
        ),
      ),
    ];
  }

  /// FlexibleSpace background with profile and buttons
  Widget _buildFlexibleBackground(
    double t,
    List<Map<String, dynamic>> rateComment,
  ) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 120),
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: t,
        child: Column(
          children: [
            _buildProfileSection(rateComment),
            SizedBox(height: 10),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  /// Profile Picture + Name + Specialty + Rate/Comments
  Widget _buildProfileSection(List<Map<String, dynamic>> rateComment) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(image),
            radius: 60,
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyle.bold18(color: AppColors.white)),
              Text(
                specialty,
                style: AppTextStyle.regular14(color: AppColors.white),
              ),
              SizedBox(height: 14),
              Row(
                spacing: 10,
                children: List.generate(rateComment.length, (index) {
                  final item = rateComment[index];
                  return Container(
                    width: 43,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: item['onTap'],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item['icon'],
                            size: 14,
                            color: AppTheme.primarySwatch,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '${item['value']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Action Buttons below profile
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Gradient Button
        Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [AppTheme.primarySwatch, AppTheme.secondarySwatch[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(
                  Icons.medical_information_outlined,
                  color: AppTheme.primarySwatch,
                  size: 18,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '15 years',
                      style: AppTextStyle.bold12(color: AppColors.black),
                    ),
                    Text(
                      'experience',
                      style: AppTextStyle.regular10(color: AppColors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        // Solid Button
        Container(
          width: 250,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.4, color: AppTheme.primarySwatch),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Icon(
                Icons.timer_outlined,
                color: AppTheme.primarySwatch,
                size: 18,
              ),
              Text(
                'Mon-Sat / 9:00AM - 5:00PM',
                style: AppTextStyle.regular14(color: AppColors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ------------------------------
  /// Page Content
  /// ------------------------------
  Widget _buildContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (focus.isNotEmpty) _buildFocusSection(),
            _buildTextSection("About Doctor", profile),
            const SizedBox(height: 30),
            _buildTextSection("Career Path", careerPath),
            const SizedBox(height: 30),
            _buildTextSection("Highlights", highlights),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: AppTheme.primarySwatch.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Focus:",
            style: AppTextStyle.bold16(color: AppTheme.primarySwatch),
          ),
          const SizedBox(height: 10),
          Text(focus, style: AppTextStyle.regular14(color: AppColors.black)),
        ],
      ),
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.bold16(color: AppColors.black)),
        const SizedBox(height: 10),
        Text(content, style: AppTextStyle.regular14(color: AppColors.black)),
      ],
    );
  }

  /// ------------------------------
  /// Icon Widgets
  /// ------------------------------
  Widget _buildCircleIconOutline(String asset) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.4, color: AppColors.white),
        color: AppTheme.primarySwatch,
      ),
      child: Center(
        child: Image.asset(
          asset,
          width: 18,
          height: 18,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildCircleIconFilled(String asset) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      child: Center(
        child: Image.asset(
          asset,
          width: 18,
          height: 18,
          color: AppTheme.primarySwatch,
        ),
      ),
    );
  }
}
