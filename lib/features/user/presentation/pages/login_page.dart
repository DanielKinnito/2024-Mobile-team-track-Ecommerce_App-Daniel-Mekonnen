import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/login_bloc.dart';
import '../widgets/build_textfield.dart';
import '../widgets/logo.dart'; // Ensure correct import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.pushNamed(
              context,
              '/home',
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70),
                const Logo(),
                const SizedBox(height: 50.0),
                const Text(
                  'Sign into your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32.0),
                Text(
                  'Email',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(111, 111, 111, 1),
                      height: 49.85 / 16.0,
                      letterSpacing: 2 / 100 * 16.0,
                    ),
                  ),
                ),
                BuildTextField(
                  controller: _emailController,
                  hintText: 'ex: jon.smith@email.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Password',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(111, 111, 111, 1),
                      height: 49.85 / 16.0,
                      letterSpacing: 2 / 100 * 16.0,
                    ),
                  ),
                ),
                BuildTextField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: '********',
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPressed(
                        email: email,
                        password: password,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: const Color.fromARGB(255, 54, 104, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Color.fromARGB(255, 54, 104, 255),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
