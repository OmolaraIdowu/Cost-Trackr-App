import 'package:cost_trackr/screens/login.dart';
import 'package:cost_trackr/widgets/bottom_nav.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:cost_trackr/widgets/textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _acceptTerms = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

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
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  void _signUp() async {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      setState(() {
        _isLoading = true;
      });

      // Sign up delay...like a network call
      await Future.delayed(const Duration(seconds: 6));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Navigate to the LoginScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept terms and conditions'),
        ),
      );
    }
  }

  void _signupWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    // Simulate network call delay for Google sign-up
    await Future.delayed(const Duration(seconds: 6));

    if (!mounted) return;

    setState(() {
      _isGoogleLoading = false;
    });

    // Add actual Google sign-up functionality here
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
                    Text('Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18)),

                    const SizedBox(height: 70),

                    CustomTextfield(
                      heading: 'Name',
                      hint: 'Enter Name',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: _validateName,
                    ),

                    const SizedBox(height: 16),

                    CustomTextfield(
                      heading: 'Email',
                      hint: 'Enter Email',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
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
                      helperText:
                          'Password must be at least 8 characters, include an uppercase, a lowercase, a number, and a special character.',
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),

                    // Terms and Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                          side: const BorderSide(
                            color: Color(0xFF005CE7),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: const Color(0xFF005CE7),
                          value: _acceptTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptTerms = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const BottomNavScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'By signing up, you agree to the ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          'Terms of Service and Privacy Policy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(fontSize: 12))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 120),

                    // Sign In
                    Stack(children: [
                      CustomButton(
                        text: _isLoading ? '' : 'Sign Up',
                        onPressed: _isLoading ? null : _signUp,
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
                        text: _isGoogleLoading ? '' : 'Sign Up with Google',
                        onPressed: _isGoogleLoading ? null : _signupWithGoogle,
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
                              builder: (ctx) => const LoginScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Log In',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
