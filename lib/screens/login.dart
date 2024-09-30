import 'package:cost_trackr/screens/home.dart';
import 'package:cost_trackr/screens/signup.dart';
import 'package:cost_trackr/widgets/bottom_nav.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:cost_trackr/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';

  bool obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _login() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      // Login delay...like a network call
      await Future.delayed(const Duration(seconds: 5));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Navigate to the HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavScreen(),
        ),
      );
    }
  }

  void _loginWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    // Simulate network call delay for Google sign-in
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isGoogleLoading = false;
    });

    // Add actual Google sign-in functionality here

    // Navigate to the HomeScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const BottomNavScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Log In',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18)),

                  const SizedBox(height: 68),

                  CustomTextfield(
                    heading: 'Email',
                    hint: 'Enter Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    onSaved: (value) {
                      _enteredEmail = value!;
                    },
                  ),

                  const SizedBox(height: 16),

                  CustomTextfield(
                    heading: 'Password',
                    hint: 'Enter Password',
                    textInputAction: TextInputAction.done,
                    obscureText: obscurePassword,
                    isPassword: true,
                    onPasswordToggle: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    validator: _validatePassword,
                    onSaved: (value) {
                      _enteredPassword = value!;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                    ],
                  ),

                  const SizedBox(height: 120),

                  // Sign In
                  Stack(children: [
                    CustomButton(
                      text: _isLoading ? '' : 'Log In',
                      onPressed: _isLoading ? null : _login,
                    ),
                    if (_isLoading)
                      const Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF005CE7)),
                          ),
                        ),
                      ),
                  ]),

                  const SizedBox(height: 25),

                  Stack(children: [
                    CustomButton(
                      text: _isGoogleLoading ? '' : 'Log In with Google',
                      onPressed: _isGoogleLoading ? null : _loginWithGoogle,
                      backgroundColor: const Color(0xFFF5F5F5),
                      foregroundColor: Colors.black,
                      icon: _isGoogleLoading
                          ? null
                          : Image.asset(
                              'assets/images/google.png',
                              height: 24,
                              width: 24,
                            ),
                    ),
                    if (_isGoogleLoading)
                      const Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF005CE7)),
                          ),
                        ),
                      ),
                  ]),

                  const SizedBox(height: 55),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const SignupScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "New to Cost Trackr? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign Up',
                                style:
                                    Theme.of(context).textTheme.headlineMedium)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
