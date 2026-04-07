import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/splash_screen_dark.dart';
import 'screens/login_screen.dart';
import 'screens/login_screen_dark.dart';
import 'screens/signup_screen.dart';
import 'screens/signup_screen_dark.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/forgot_password_dark.dart';

void main() => runApp(const FuelixApp());

class FuelixApp extends StatelessWidget {
  const FuelixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FueliX',
      debugShowCheckedModeBanner: false,
      
      // Thème Clair
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
      ),
      
      // Thème Sombre
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F2A44),
      ),
      
      themeMode: ThemeMode.system, // Utilise le réglage iOS/Android

      // Utilise un widget simple qui décide de l'écran à afficher
      home: const ThemeGateway(),

      // Routes nommées simplifiées
      routes: {
        '/login': (context) => _buildResponsiveScreen(context, const LoginScreen(), const LoginScreenDark()),
        '/signup': (context) => _buildResponsiveScreen(context, const SignUpScreen(), const SignUpScreenDark()),
        '/forgot-password': (context) => _buildResponsiveScreen(context, const ForgotPasswordScreen(), const ForgotPasswordDark()),
      },
    );
  }

  // Fonction utilitaire pour choisir l'écran selon le mode
  Widget _buildResponsiveScreen(BuildContext context, Widget light, Widget dark) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return isDark ? dark : light;
  }
}

// Petit widget passerelle pour la Splash Screen
class ThemeGateway extends StatelessWidget {
  const ThemeGateway({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return isDark ? const SplashScreenDark() : const SplashScreen();
  }
}