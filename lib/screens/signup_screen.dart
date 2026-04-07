import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController(); // Nouveau
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2A44)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/logo_fuelix.png', width: 70),
              const SizedBox(height: 20),
              const Text("Create Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0F2A44))),
              const SizedBox(height: 8),
              const Text("Fill in the details to get started", style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 25),
              
              _buildTextField(controller: _nameController, hintText: "Full Name"),
              const SizedBox(height: 12),
              
              _buildTextField(controller: _emailController, hintText: "Email address", keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),

              _buildTextField(controller: _phoneController, hintText: "Phone Number", keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              
              // NOUVEAU : Champ Ville
              _buildTextField(controller: _cityController, hintText: "City"),
              const SizedBox(height: 12),
              
              _buildTextField(controller: _passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 12),
              
              _buildTextField(controller: _confirmPasswordController, hintText: "Confirm Password", obscureText: true),
              
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Validation
                    if (_passwordController.text != _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match!"), backgroundColor: Colors.redAccent),
                      );
                      return;
                    }
                    // Logique d'inscription avec la ville
                    print("Registration for ${_nameController.text} from ${_cityController.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2A945),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: const Text("Sign Up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Widget TextField simplifié et polyvalent
  Widget _buildTextField({
    required TextEditingController controller, 
    required String hintText, 
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}