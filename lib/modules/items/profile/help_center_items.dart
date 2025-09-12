import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/config/app_asset/app_assets.dart';
import 'package:medical_app/config/function/launch_url.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/widgets/custom_tab_bar.dart';

class HelpCenterItems extends StatelessWidget {
  const HelpCenterItems({super.key});

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 170;

    final String selectedSpecialty = Get.arguments ?? "Help center";

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
                                      'how can we help you?',
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
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(children: [_buildTabBodyContent]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _buildTabBodyContent {
    return AnimatedRoundedTabbarFilled(
      tabWidth: 190,
      tabs: ['FAQ', 'Contact Us'],
      tabContents: [_buildFAQTabContext, _buildContactUS],
    );
  }

  get _buildFAQTabContext {
    return AnimatedRoundedTabbarFilled(
      tabWidth: 130,
      //General = Service
      tabs: ['Popular Topic', 'General', 'Services'],
      tabContents: [_buildPopularTopic, _buildGeneralTopic, _buildGeneralTopic],
    );
  }

  get _buildContactUS {
    return Column(children: [_buildListTitle]);
  }

  Widget get _buildListTitle {
    // List of menu items with onTap actions
    List<Map<String, dynamic>> listData = [
      {
        'title': 'Customer service',
        'icon': AppAssets.headphone,
        'onTap': () {
          LaunchUrl.launchPhone('+1234567890');
        },
      },
      {
        'title': 'website',
        'icon': AppAssets.web,
        'onTap': () {
          LaunchUrl.launch('https://example.com');
        },
      },
      {
        'title': 'Whatsapp',
        'icon': AppAssets.headphone,
        'onTap': () {
          LaunchUrl.launchWhatsApp('1234567890');
        },
      },
      {
        'title': 'Facebook',
        'icon': AppAssets.facebook,
        'onTap': () {
          LaunchUrl.launch('https://www.facebook.com/example');
        },
      },
      {
        'title': 'Instagram',
        'icon': AppAssets.instagram,
        'onTap': () {
          LaunchUrl.launch('https://www.instagram.com/example');
        },
      },
      {
        'title': 'Email',
        'icon': AppAssets.web,
        'onTap': () {
          LaunchUrl.launchEmail('support@example.com');
        },
      },
    ];

    return Column(
      children: listData.map((item) {
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondarySwatch,
            ),
            child: Image.asset(item['icon']),
            // child: Icon(item['icon'], color: Colors.white),
          ),
          title: Text(
            item['title'],
            style: AppTextStyle.regular14(color: AppColors.black),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppTheme.primarySwatch,
          ),
          onTap: item['onTap'],
        );
      }).toList(),
    );
  }

  //
  get _buildPopularTopic {
    // List of dropdown items for each tab
    final List<List<List<String>>> tabItems = [
      // Popular Topic
      [
        [
          'Booking an Appointment',
          'Payment and Billing',
          'Medical Records',
          'Prescription Refills',
        ],
        [
          'How to cancel an appointment?',
          'Insurance and Payments',
          'View test results',
          'Request a doctor referral',
        ],
        [
          'Lab Services',
          'Pharmacy Services',
          'Home Visit Services',
          'Telemedicine Services',
        ],
      ],
    ];
    return SingleChildScrollView(
      child: Column(
        children: tabItems[0]
            .map(
              (items) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomDropdown(items: items),
              ),
            )
            .toList(),
      ),
    );
  }

  get _buildGeneralTopic {
    // List of dropdown items for each tab
    final List<List<List<String>>> tabItems = [
      // Popular Topic
      [
        [
          'Booking an Appointment',
          'Payment and Billing',
          'Medical Records',
          'Prescription Refills',
        ],
        [
          'How to cancel an appointment?',
          'Insurance and Payments',
          'View test results',
          'Request a doctor referral',
        ],
        [
          'Lab Services',
          'Pharmacy Services',
          'Home Visit Services',
          'Telemedicine Services',
        ],
      ],
    ];
    return SingleChildScrollView(
      child: Column(
        children: tabItems[0]
            .map(
              (items) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomDropdown(items: items),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;

  const CustomDropdown({super.key, required this.items, this.initialValue});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value!;
          });
        },
        underline: const SizedBox(),
        isExpanded: true,
        dropdownColor: Theme.of(context).colorScheme.surface,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppTheme.primarySwatch,
        ),
        selectedItemBuilder: (BuildContext context) {
          return widget.items
              .map(
                (String value) =>
                    Align(alignment: Alignment.centerLeft, child: Text(value)),
              )
              .toList();
        },
        items: widget.items
            .map(
              (String value) =>
                  DropdownMenuItem<String>(value: value, child: Text(value)),
            )
            .toList(),
      ),
    );
  }
}
