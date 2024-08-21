import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarTitle extends StatefulWidget {
  const AppBarTitle({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User'; // Fallback if name is not found
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormatter = DateFormat('MMMM, yyyy');
    final formattedDate = dateFormatter.format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
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
              userName,  // Display the fetched user name
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
