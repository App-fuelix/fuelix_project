import 'package:flutter/material.dart';

class SignUpScreenDark extends StatefulWidget {
  const SignUpScreenDark({super.key});
  @override
  State<SignUpScreenDark> createState() => _SignUpScreenDarkState();
}

class _SignUpScreenDarkState extends State<SignUpScreenDark> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FOND SOMBRE : #0F2A44
      backgroundColor: const Color(0xFF0F2A44),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF4F6F8)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/logo_fuelix_2.png', width: 70),
              const SizedBox(height: 20),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFFF4F6F8),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Fill in the details to get started", 
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 25),
              
              _buildTextField(controller: _nameController, hintText: "Full Name"),
              const SizedBox(height: 12),
              
              _buildTextField(
                controller: _emailController, 
                hintText: "Email address", 
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _phoneController, 
                hintText: "Phone Number", 
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              
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
                    if (_passwordController.text != _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match!"), 
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }
                    print("Registration for ${_nameController.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2A945),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller, 
    required String hintText, 
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15, color: Color(0xFF0F2A44)),
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