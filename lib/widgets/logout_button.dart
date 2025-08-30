import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';

class LogOutButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData? icon;
  const LogOutButton({
    required this.text,
    required this.onPressed,
    this.icon = Icons.arrow_forward_ios,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.red;
    const double borderRadius = 12;
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          BorderSide(color: primaryColor, width: 1.1),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 14)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            text,
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: primaryColor,
            ),
          ),
          if (icon != null) ...[
            SizedBox(width: 10),
            Icon(icon, color: primaryColor),
          ],
        ],
      ),
    );
  }
}
