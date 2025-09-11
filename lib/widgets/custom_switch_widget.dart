import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class AdvanceSwitchFlutter extends StatefulWidget {
  final double radius;
  final double thumbRadius;
  final Widget? activeChild;
  final Widget? inactiveChild;
  const AdvanceSwitchFlutter({
    super.key,
    required this.radius,
    required this.thumbRadius,
    this.activeChild,
    this.inactiveChild,
  });

  @override
  State<AdvanceSwitchFlutter> createState() => _AdvanceSwitchFlutterState();
}

class _AdvanceSwitchFlutterState extends State<AdvanceSwitchFlutter> {
  final _controller00 = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      activeColor: AppTheme.primarySwatch,
      inactiveColor: AppTheme.primarySwatch[200] ?? Colors.grey,
      activeChild: SizedBox(),
      inactiveChild: const SizedBox(),
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      width: 56,
      height: 28,
      thumb: Container(
        margin: EdgeInsets.all(2),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(widget.thumbRadius),
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: _controller00,
          builder: (_, value, __) {
            return value ? widget.activeChild! : widget.inactiveChild!;
          },
        ),
      ),
      controller: _controller00,
    );
  }
}
