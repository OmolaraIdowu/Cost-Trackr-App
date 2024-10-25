import 'package:cost_trackr/screens/auth/email_verification.dart';
import 'package:cost_trackr/screens/auth/signup.dart';
import 'package:cost_trackr/screens/bottom_nav.dart';
import 'package:cost_trackr/services/auth_service.dart';
import 'package:cost_trackr/utils/form_validator.dart';
import 'package:cost_trackr/utils/snackbar.dart';
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
  final AuthService _authService = AuthService();

  var _enteredEmail = '';
  var _enteredPassword = '';
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void login() async {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      _formKey.currentState!.save();

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );

      final AuthResult result =
          await _authService.signInUser(_enteredEmail, _enteredPassword);

      if (result.isSuccess) {
        // Successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const BottomNavScreen()),
        );
      } else {
        // Error occurred
        context.showSnackBar(result.errorMessage!);
      }

      Navigator.of(context).pop(); // Dismiss the loading dialog
    }

    void loginWithGoogle() async {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ),
        ),
      );

      final AuthResult result = await _authService.signInWithGoogle();

      if (result.isSuccess) {
        // Successful login
        context.showSnackBar('Login with Google successful');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomNavScreen(),
          ),
        );
      } else {
        // Error occurred
        context.showSnackBar(result.errorMessage!);
      }
      Navigator.of(context).pop(); // Dismiss the loading dialog
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextfield(
                    heading: 'Email',
                    hint: 'Enter Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidator.validateEmail,
                    onSaved: (value) => _enteredEmail = value!,
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
                    validator: FormValidator.validateLoginPassword,
                    onSaved: (value) => _enteredPassword = value!,
                  ),

                  const SizedBox(height: 16),

                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const EmailVerificationScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forgot Password?',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 120),

                  // Sign In
                  CustomButton(
                    text: 'Log In',
                    onPressed: login,
                  ),

                  const SizedBox(height: 25),

                  CustomButton(
                    text: 'Log In with Google',
                    onPressed: loginWithGoogle,
                    backgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: Colors.black,
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 24,
                      width: 24,
                    ),
                  ),

                  const SizedBox(height: 55),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => const SignupScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "New to Cost Trackr? ",
                          style: theme.textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            )
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
