import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/login_screen.dart';
import 'package:frontend/consts/colors.dart';
import 'package:frontend/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    final currentContext = context; // Store the context locally

    Future.delayed(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (mounted) {
          // Check if the widget is still mounted and context is not null
          if (user == null) {
            Navigator.of(currentContext).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else {
            Navigator.of(currentContext).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to your personalised',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: fontwhite,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Notes App',
              style: TextStyle(
                fontSize: 24,
                color: buttonColor,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
