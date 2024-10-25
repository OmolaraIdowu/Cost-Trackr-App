import 'package:cost_trackr/model/user.dart';
import 'package:cost_trackr/screens/auth/email_verification.dart';
import 'package:cost_trackr/screens/auth/login.dart';
import 'package:cost_trackr/screens/bottom_nav.dart';
import 'package:cost_trackr/services/auth_service.dart';
import 'package:cost_trackr/services/firestore_service.dart';
import 'package:cost_trackr/utils/form_validator.dart';
import 'package:cost_trackr/utils/snackbar.dart';
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
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPassword = '';

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void _signUp() async {
      // Validate form fields
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      _formKey.currentState!.save();

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

      try {
        // Authenticate user
        final result =
            await _authService.signUpUser(_enteredEmail, _enteredPassword);

        if (result.isSuccess) {
          final userData = UserData(
            uid: result.userCredential!.user!.uid,
            email: _enteredEmail,
            name: _enteredName,
          );

          // Save user data
          await _firestoreService.saveUserData(userData);
          // Successful sign-up
          context.showSnackBar('Sign up successful');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => const EmailVerificationScreen()),
          );
        } else {
          // Error occurred during sign-up
          context.showSnackBar(result.errorMessage!);
        }
      } catch (error) {
        // Handle unexpected errors
        context.showSnackBar('An unexpected error occurred: $error');
      } finally {
        Navigator.of(context).pop(); // Dismiss the loading dialog
      }
    }

    void signUp() async {
      // Validate form fields
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

      try {
        // Authenticate user
        final result =
            await _authService.signUpUser(_enteredEmail, _enteredPassword);

        if (result.isSuccess) {
          final userData = UserData(
            uid: result.userCredential!.user!.uid,
            email: _enteredEmail,
            name: _enteredName,
          );

          // Save user data
          await _firestoreService.saveUserData(userData);

          // Successful sign-up
          context.showSnackBar('Sign up successful');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const BottomNavScreen()),
          );
        } else {
          // Error occurred during sign-up
          context.showSnackBar(result.errorMessage!);
        }
      } catch (error) {
        // Handle unexpected errors
        context.showSnackBar('An unexpected error occurred: $error');
      } finally {
        Navigator.of(context).pop(); // Dismiss the loading dialog
      }
    }

    void signupWithGoogle() async {
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

      // Sign up using Google
      final result = await _authService.signInWithGoogle();

      if (result.isSuccess) {
        // Successful sign-up
        context.showSnackBar('Sign up with Google successful');
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
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextfield(
                  heading: 'Name',
                  hint: 'Enter Name',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: FormValidator.validateName,
                  onSaved: (value) => _enteredName = value!,
                ),
                const SizedBox(height: 16),
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
                  helperText:
                      'Password must be at least 8 characters, include an uppercase, lowercase, a number, and a special character.',
                  validator: FormValidator.validateSignupPassword,
                  onSaved: (value) => _enteredPassword = value!,
                ),
                const SizedBox(height: 16),
                FormField<bool>(
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox.adaptive(
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              value: state.value ??
                                  false, // Bind with FormField state
                              onChanged: (value) {
                                state.didChange(
                                    value); // Notify FormField of the change
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'By signing up, you agree to the ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text:
                                          'Terms of Service and Privacy Policy',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state.hasError) // If validation fails, show error
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 12),
                            child: Text(state.errorText!,
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.red)),
                          ),
                      ],
                    );
                  },
                  validator: FormValidator.validateTerms,
                ),
                const SizedBox(height: 120),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: signUp,
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: 'Sign Up with Google',
                  onPressed: signupWithGoogle,
                  backgroundColor: const Color(0xFFF5F5F5),
                  foregroundColor: Colors.black,
                  icon: Image.asset('assets/images/google.png', height: 24),
                ),
                const SizedBox(height: 55),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: theme.textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Log In',
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor))
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
    );
  }
}
