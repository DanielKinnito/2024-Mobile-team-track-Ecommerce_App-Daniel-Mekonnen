import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_icon_button.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: CustomIconButton(
          icon: Icons.menu,
          color: Colors.grey,
          onPressed: () {},
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'July, 2024',
            style: GoogleFonts.syne(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Text(
                'Hello, ',
                style: GoogleFonts.sora(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(102, 102, 102, 1),
                ),
              ),
              Text(
                'Daniel',
                style: GoogleFonts.sora(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CustomIconButton(
            icon: Icons.notifications_outlined,
            color: Colors.grey,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
