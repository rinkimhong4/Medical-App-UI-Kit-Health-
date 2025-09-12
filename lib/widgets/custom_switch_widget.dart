import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_app/config/theme/theme_style.dart';

/// usage
// AdvanceSwitchFlutter(
//   radius: 40,
//   thumbRadius: 30,
//   storageKey: title.replaceAll(' ', '_').toLowerCase(),
//   activeChild: Icon(Icons.check, size: 18, color: Colors.blue),
//   inactiveChild: Icon(
//     Icons.close,
//     size: 18,
//     color: Colors.black38,
//   ),
// ),

class AdvanceSwitchFlutter extends StatefulWidget {
  final double radius;
  final double thumbRadius;
  final Widget? activeChild;
  final Widget? inactiveChild;
  final String storageKey;

  const AdvanceSwitchFlutter({
    super.key,
    required this.radius,
    required this.thumbRadius,
    required this.storageKey,
    this.activeChild,
    this.inactiveChild,
  });

  @override
  State<AdvanceSwitchFlutter> createState() => _AdvanceSwitchFlutterState();
}

class _AdvanceSwitchFlutterState extends State<AdvanceSwitchFlutter> {
  late final ValueNotifier<bool> _controller;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    _controller = ValueNotifier<bool>(false);

    Future.microtask(() {
      final savedValue = box.read(widget.storageKey) ?? false;
      _controller.value = savedValue;
    });

    _controller.addListener(() {
      box.write(widget.storageKey, _controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: _controller,
      activeColor: AppTheme.primarySwatch,
      inactiveColor: Colors.grey[100]!,
      borderRadius: BorderRadius.circular(widget.radius),
      width: 56,
      height: 28,
      thumb: Container(
        margin: const EdgeInsets.all(2),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(widget.thumbRadius),
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: _controller,
          builder: (_, value, __) {
            return value
                ? (widget.activeChild ?? const SizedBox())
                : (widget.inactiveChild ?? const SizedBox());
          },
        ),
      ),
    );
  }
}
