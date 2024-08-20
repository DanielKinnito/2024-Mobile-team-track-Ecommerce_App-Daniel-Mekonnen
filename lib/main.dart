// // import 'package:myapp/start-feature/presentation/pages/home_page.dart';
// // import 'package:myapp/start-feature/presentation/pages/details_page.dart';
// // import 'package:myapp/start-feature/presentation/pages/add_update_page.dart';
// // import 'package:myapp/start-feature/presentation/pages/search_page.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'features/product/domain/entities/product.dart';
// import 'features/product/presentation/pages/product_add_page.dart';
// import 'features/product/presentation/pages/product_details_page.dart';
// import 'features/product/presentation/pages/product_home_page.dart';
// import 'features/product/presentation/pages/product_search_page.dart';
// import 'features/product/presentation/pages/product_update_page.dart';
// import 'injection_container.dart' as di;

// const product = Product(
//   imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777711/images/clmxnecvavxfvrz9by4w.jpg',
//   id: '6672776eb905525c145fe0bb',
//   name: 'Anime website',
//   description: 'Explore anime characters.',
//   price: 123.0,
//   );
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: const RootPage(),
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/home':
//             return MaterialPageRoute(
//               builder: (context) => const ProductHomePage(),
//             );
//           case '/details':
//             return MaterialPageRoute(
//               builder: (context) => const ProductDetailsPage(product: product, id:product,),
//             );
//           case '/add':
//             return MaterialPageRoute(
//               builder: (context) => const ProductAddPage(),
//             );
//           case '/update':
//             return MaterialPageRoute(
//               builder: (context) => const ProductUpdatePage(product: product,),
//             );
//           case '/search':
//             return MaterialPageRoute(
//               builder: (context) => ProductSearchPage(),
//             );
//           default:
//             return MaterialPageRoute(
//               builder: (context) => const RootPage(),
//             );
//         }
//       },
//     );
//   }
// }

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: ProductHomePage(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/product/presentation/pages/product_home_page.dart';
import 'features/user/domain/usecase/login_user.dart';
import 'features/user/domain/usecase/register_user.dart';
import 'features/user/presentation/bloc/login_bloc.dart';
import 'features/user/presentation/bloc/register_bloc.dart';
import 'features/user/presentation/pages/login_page.dart';
import 'features/user/presentation/pages/register_page.dart';
import 'features/user/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(
            registerUser: di.sl<RegisterUser>(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            loginUser: di.sl<LoginUser>(),
            sharedPreferences: di.sl<SharedPreferences>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/signin': (context) => const LoginPage(),
          '/signup': (context) => const RegisterPage(),
          '/home': (context) => const ProductHomePage(),
        },
      ),
    );
  }
}
