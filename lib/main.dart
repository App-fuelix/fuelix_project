import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/security_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';

// Notificateur global pour le thème
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() => runApp(const FuelixApp());

class FuelixApp extends StatelessWidget {
  const FuelixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'FueliX',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode, 

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF4F6F8),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFF2A945),
              surface: Colors.white,
            ),
          ),
          
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0F2A44),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFF2A945),
              surface: Color(0xFF1B3B5A),
            ),
          ),

          home: const DashboardScreen(),

          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/forgot-password': (context) => const ForgotPasswordScreen(),
            '/home': (context) => const DashboardScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/edit-profile': (context) => const EditProfileScreen(),
            '/security': (context) => const SecurityScreen(),
          },
        );
      },
    );
  }
}