import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importation nécessaire pour la redirection [cite: 89, 91]

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Redirection vers l'écran de Login après 3 secondes, conformément au planning [cite: 135]
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Utilisation du fond spécifique #F4F6F8 défini pour l'application [cite: 61]
      backgroundColor: const Color(0xFFF4F6F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CORRECTION : Utilisation d'un chemin relatif pour l'asset
            Image.asset(
              'assets/images/logo_fuelix.png', 
              width: 250,
            ),
            const SizedBox(height: 12),
            // Slogan officiel de FueliX [cite: 6, 30]
            const Text(
              "Fuel management. Smarter.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0F2A44), // Couleur bleu foncé de la charte
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}