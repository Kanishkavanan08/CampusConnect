import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider

import 'theme/app_theme.dart';
import 'screens/auth/splash_screen.dart';
import 'providers/task_provider.dart'; // Import our new provider

void main() {
  runApp(
    // Wrap the app in a MultiProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: const CampusConnectApp(),
    ),
  );
}

class CampusConnectApp extends StatelessWidget {
  const CampusConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}