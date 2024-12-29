import 'package:flutter/material.dart';
import 'package:sippify/colors.dart'; // Assuming xprimaryColor is defined here.

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColor;
  final double fontSize;
  final double borderRadius;
  final bool isEnabled;
  final double? width;

  const CommonButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.buttonColor,
    this.textColor,
    this.fontSize = 16.0,
    this.borderRadius = 15.0,
    this.isEnabled = true,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveButtonColor = buttonColor ?? xprimaryColor; // Use xprimaryColor as default.
    final effectiveTextColor = textColor ?? Colors.white;

    return Material(
      color: isEnabled ? effectiveButtonColor : effectiveButtonColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: isEnabled ? onTap : null,
        splashColor: Colors.white.withOpacity(0.2),
        child: SizedBox(
          height: 55,
          width: width ?? double.infinity,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                color: isEnabled ? effectiveTextColor : effectiveTextColor.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
