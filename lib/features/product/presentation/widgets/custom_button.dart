import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconSize,
    this.padding,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? const EdgeInsets.all(16.0),
        foregroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: Icon(
        icon,
        size: iconSize ?? 24.0,
      ),
    );
  }
}