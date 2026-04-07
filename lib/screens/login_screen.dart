import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/images/logo_fuelix.png', width: 130),
              const SizedBox(height: 60),
              const Text("Welcome Back", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F2A44))),
              const SizedBox(height: 10),
              const Text("Sign in to continue", 
                style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
              const SizedBox(height: 45),
              _buildTextField(controller: _emailController, hintText: "Email address", obscureText: false),
              const SizedBox(height: 20),
              _buildTextField(controller: _passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () { /* Logique */ },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2A945),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text("Sign In", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                child: const Text("Forgot password?", 
                  style: TextStyle(color: Color(0xFF0F2A44), fontSize: 15, decoration: TextDecoration.underline)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF0F2A44))),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text("Sign Up",
                      style: TextStyle(color: Color(0xFFF2A945), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText, required bool obscureText}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xFF0F2A44), fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}