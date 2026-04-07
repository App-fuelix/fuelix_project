import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenDark extends StatefulWidget {
  const SplashScreenDark({super.key});

  @override
  State<SplashScreenDark> createState() => _SplashScreenDarkState();
}

class _SplashScreenDarkState extends State<SplashScreenDark> {
  @override
  void initState() {
    super.initState();
    // Redirection automatique vers l'écran de Login après 3 secondes
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // En utilisant pushReplacementNamed, on s'assure que l'utilisateur
        // ne peut pas revenir en arrière vers la Splash Screen.
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CORRECTION COULEUR : Couleur de fond demandée #0F2A44
      backgroundColor: const Color(0xFF0F2A44),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichage de ton DEUXIÈME logo (version claire/blanche)
            Image.asset(
              'assets/images/logo_fuelix_2.png',
              width: 250, // Ajuste la taille selon ton besoin
            ),
            const SizedBox(height: 12),
            // CORRECTION TEXTE : Couleur demandée #F4F6F8
            const Text(
              "Fuel management. Smarter.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFF4F6F8), // Couleur claire pour le texte
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}