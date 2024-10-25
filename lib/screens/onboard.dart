import 'package:cost_trackr/screens/auth/login.dart';
import 'package:cost_trackr/screens/auth/signup.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(children: [
              Image.asset(
                'assets/images/welcome_image.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50),
              Text(
                "Gain Total Control of Your Money",
                textAlign: TextAlign.center,
                style: theme.headlineLarge!
                    .copyWith(color: const Color(0xFF005CE7)),
              ),
              const SizedBox(height: 50),
              CustomButton(
                width: 300,
                text: 'Get Started',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const SignupScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
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
                      style: theme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log In',
                          style: theme.titleMedium!
                              .copyWith(color: const Color(0xFF005CE7)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
