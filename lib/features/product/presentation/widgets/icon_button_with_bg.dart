import 'package:flutter/material.dart';

class IconButtonWithBg extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const IconButtonWithBg({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.grey),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }
}
