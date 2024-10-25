import 'package:cost_trackr/services/auth_service.dart';
import 'package:cost_trackr/utils/form_validator.dart';
import 'package:cost_trackr/utils/snackbar.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:cost_trackr/widgets/textfield.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  var _enteredEmail = '';

  void _resetPassword() async {
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

    final AuthResult result = await _authService.resetPassword(_enteredEmail);
    if (result.isSuccess) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Password reset link sent! Check your email.'),
        ),
      );
    } else {
      context.showSnackBar(result.errorMessage.toString());
    }

    Navigator.of(context).pop(); // Dismiss the loading dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Enter email associated with your account and we will send you an email with instructions to reset password.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    heading: 'Email',
                    hint: 'Enter email',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidator.validateEmail,
                    onSaved: (value) => _enteredEmail = value!,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Reset Password',
                    onPressed: _resetPassword,
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
