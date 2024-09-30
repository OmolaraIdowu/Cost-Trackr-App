import 'package:cost_trackr/screens/onboard.dart';
import 'package:cost_trackr/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// final colorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.light,
//   seedColor: const Color(0xFF005CE7),
// );

// final theme = ThemeData(
//   useMaterial3: true,
//   scaffoldBackgroundColor: Colors.white,
//   colorScheme: colorScheme,
//   textTheme: const TextTheme(
//     titleSmall: TextStyle(
//       fontFamily: 'Poppins',
//       fontWeight: FontWeight.normal,
//       fontSize: 12,
//     ),
//     titleMedium: TextStyle(
//       fontFamily: 'Poppins',
//       fontWeight: FontWeight.w500,
//       fontSize: 14,
//     ),
//     titleLarge: TextStyle(
//       fontFamily: 'Poppins',
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     ),
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: colorScheme.onSecondary,
//   ),
// );

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initialization(null);
  FlutterNativeSplash.remove();
  debugPrint("Splash screen removed");

  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cost Trackr',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const OnboardScreen(),
    );
  }
}
