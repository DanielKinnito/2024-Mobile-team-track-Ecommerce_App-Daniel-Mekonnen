import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 143,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              color: const Color.fromARGB(255, 54, 104, 255), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'ECOM',
            style: GoogleFonts.caveatBrush(
              textStyle: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 54, 104, 255),
                height: 24.26 / 48.0,
                letterSpacing: 2 / 100 * 48.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
