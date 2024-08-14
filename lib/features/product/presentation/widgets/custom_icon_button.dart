import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        )),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }
}
