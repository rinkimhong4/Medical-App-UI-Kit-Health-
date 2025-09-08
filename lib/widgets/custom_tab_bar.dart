import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class AnimatedRoundedTabbarFilled extends StatefulWidget {
  final double borderRadius;
  final List<String> tabs;
  final List<Widget> tabContents;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;
  final EdgeInsets tabPadding;
  final Duration animationDuration;
  final Curve animationCurve;
  final double tabHeight;
  final double? tabWidth;
  final bool isScrollable;

  const AnimatedRoundedTabbarFilled({
    super.key,
    this.borderRadius = 30.0,
    required this.tabs,
    required this.tabContents,
    this.activeColor = AppTheme.primarySwatch,
    this.inactiveColor = Colors.white,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.tabHeight = 40.0,
    this.isScrollable = false,
    this.tabWidth = 120,
  }) : assert(
         tabs.length == tabContents.length,
         'Tabs and contents must have the same length',
       );

  @override
  State<AnimatedRoundedTabbarFilled> createState() =>
      _AnimatedRoundedTabbarFilledState();
}

class _AnimatedRoundedTabbarFilledState
    extends State<AnimatedRoundedTabbarFilled> {
  late List<bool> _isHoverList;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _isHoverList = List.generate(widget.tabs.length, (_) => false);
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Bar
        widget.isScrollable
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildTabBar(),
              )
            : _buildTabBar(),
        SizedBox(height: 20),
        // Tab Content
        AnimatedSwitcher(
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: widget.tabContents[_currentIndex],
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.tabs.length, (index) {
        final isActive = _currentIndex == index;
        final isHovered = _isHoverList[index];
        return Semantics(
          selected: isActive,
          button: true,
          label: widget.tabs[index],
          child: InkWell(
            onTap: () {
              setState(() => _currentIndex = index);
            },
            onHover: (value) {
              if (!_isMobilePlatform(context)) {
                setState(() => _isHoverList[index] = value);
              }
            },
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: AnimatedContainer(
              width: widget.tabWidth,
              height: widget.tabHeight,
              padding: widget.tabPadding,
              alignment: Alignment.center,
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: isActive || isHovered
                    ? widget.activeColor
                    : widget.inactiveColor,
              ),
              child: Text(
                widget.tabs[index],
                style: isActive || isHovered
                    ? (widget.activeTextStyle ??
                          AppTextStyle.bold13(color: AppColors.black))
                    : (widget.inactiveTextStyle ??
                          AppTextStyle.bold13(color: AppColors.black)),
              ),
            ),
          ),
        );
      }),
    );
  }

  bool _isMobilePlatform(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  }
}
