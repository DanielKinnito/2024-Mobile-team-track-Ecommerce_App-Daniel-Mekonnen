// import 'package:myapp/start-feature/presentation/pages/home_page.dart';
// import 'package:myapp/start-feature/presentation/pages/details_page.dart';
// import 'package:myapp/start-feature/presentation/pages/add_update_page.dart';
// import 'package:myapp/start-feature/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const RootPage(),
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/details':
      //       return MaterialPageRoute(
      //         builder: (context) => const DetailsPage(),
      //       );
      //     case '/add_update':
      //       return MaterialPageRoute(
      //         builder: (context) => const AddUpdatePage(),
      //       );
      //     case '/search':
      //       return MaterialPageRoute(
      //         builder: (context) => const SearchPage(),
      //       );
      //     default:
      //       return MaterialPageRoute(
      //         builder: (context) => const RootPage(),
      //       );
      //   }
      // },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
    // return Scaffold(
    //   body: HomePage(),
    // );
  }
}