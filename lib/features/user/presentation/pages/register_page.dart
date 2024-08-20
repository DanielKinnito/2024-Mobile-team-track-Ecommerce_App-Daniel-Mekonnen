import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../injection_container.dart';
import '../../domain/usecase/register_user.dart';
import '../bloc/register_bloc.dart';
import '../widgets/build_textfield.dart';
import '../widgets/checkbox_widget.dart';
import '../widgets/custom_back_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (context) => RegisterBloc(
        registerUser: sl<RegisterUser>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const CustomBackButton(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 60,
                height: 40,
                padding: const EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 54, 104, 255), width: 2),
                ),
                child: Center(
                  child: Text(
                    'ECOM',
                    style: GoogleFonts.caveatBrush(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 54, 104, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24.0),
                Text(
                  'Create your account',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Name',
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
                  controller: nameController,
                  hintText: 'ex: Jon Smith',
                ),
                const SizedBox(height: 16.0),
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
                  controller: emailController,
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
                  controller: passwordController,
                  hintText: '********',
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Confirm Password',
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
                  controller: confirmPasswordController,
                  hintText: '********',
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const CheckboxWidget(),
                    RichText(
                      text: TextSpan(
                        text: 'I understood the ',
                        style: GoogleFonts.poppins(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'terms & policy.',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 54, 104, 255),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (kDebugMode) {
                                  print('Terms & Policy tapped');
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushNamed(context, '/signin');
                    } else if (state is RegisterError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is RegisterLoading
                          ? null
                          : () {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                context.read<RegisterBloc>().add(
                                      RegisterUserEvent(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match'),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor:
                            const Color.fromARGB(255, 54, 104, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: state is RegisterLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'SIGN UP',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: Text(
                        'SIGN IN',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 54, 104, 255),
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
