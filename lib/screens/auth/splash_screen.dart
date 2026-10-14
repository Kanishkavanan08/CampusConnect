import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'login_screen.dart'; // Import the destination screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNext(); // Call our navigation logic when the screen loads
  }

  // The async keyword lets us use 'await' to pause execution
  void _navigateToNext() async {
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still mounted (safe practice before navigating)
    if (!mounted) return;

    // Navigate to Login and remove Splash from the history stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Use our primary theme color for the background
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Name / Logo
            Text(
              'CampusConnect',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 16), // Spacing
            // A nice circular loading animation
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}