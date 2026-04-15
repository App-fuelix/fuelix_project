import 'package:flutter/material.dart';

// Import your unified screens here (we will create/fix these next)
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(const FuelixApp());

class FuelixApp extends StatelessWidget {
  const FuelixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FueliX',
      debugShowCheckedModeBanner: false,
      
      // Control center for the app's appearance
      themeMode: ThemeMode.system, 

      // LIGHT THEME CONFIGURATION
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        primaryColor: const Color(0xFF2196F3), // Example Brand Color
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2196F3),
          surface: Colors.white,
        ),
        // This ensures all text defaults to black in light mode
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      
      // DARK THEME CONFIGURATION
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F2A44),
        primaryColor: const Color(0xFF64B5F6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64B5F6),
          surface: Color(0xFF1B3A57),
        ),
        // This ensures all text defaults to white in dark mode
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),

      // Start with the single Splash Screen
      home: const DashboardScreen(),
      //home: const SplashScreen(),

      // Unified Routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const DashboardScreen(),
      },
    );
  }
}