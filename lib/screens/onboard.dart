import 'package:cost_trackr/screens/login.dart';
import 'package:cost_trackr/screens/signup.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            Image.asset(
              'assets/images/welcome_image.png',
              fit: BoxFit.cover,
            ),
            const Spacer(),
            Text(
              "Gain Total Control of Your Money",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 30),
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
