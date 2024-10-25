import 'package:cost_trackr/screens/bottom_nav.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void _verifyEmail() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email Address'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          children: [
            Image.asset(
              'assets/images/google.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            Text('Confirm your email address',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            Text(
              'We sent a confirmation email to:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10)),
                child: Text('test@example.com',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.black))),
            const SizedBox(height: 16),
            Text(
              'Please verify your email by clicking the link we sent. \nReturn to the app and tap "Verify" to complete.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Verify',
              onPressed: () {
                // _verifyEmail();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const BottomNavScreen()),
                );
              },
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    text: "Didn't receive an Email? ",
                    style: theme.textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Resend',
                        style: theme.textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
