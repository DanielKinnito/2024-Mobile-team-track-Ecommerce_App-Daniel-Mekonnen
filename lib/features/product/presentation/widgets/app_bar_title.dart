import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
