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
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // --- UNIFIED ERROR DIALOG ---
  void _showErrorDialog(String message) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF0F2A44) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFF2A945), size: 30),
            const SizedBox(width: 10),
            Text(
              "Opps!", 
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF0F2A44), 
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
        content: Text(
          message, 
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              "OK", 
              style: TextStyle(color: Color(0xFFF2A945), fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text.trim())) {
      _showErrorDialog("Please enter a valid email address.");
      return;
    }
    
    // Tunisian phone number logic from your code
    if (!RegExp(r'^[2459]\d{7}$').hasMatch(_phoneController.text.trim())) {
      _showErrorDialog("Please enter a valid phone number.");
      return;
    }

    if (_passwordController.text.length < 6) {
      _showErrorDialog("Password must be at least 6 characters.");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog("Passwords do not match!");
      return;
    }

    debugPrint("Success: Registration for ${_nameController.text}");
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color mainTextColor = isDark ? const Color(0xFFF4F6F8) : const Color(0xFF0F2A44);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainTextColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                isDark ? 'assets/images/logo_fuelix_2.png' : 'assets/images/logo_fuelix.png', 
                width: 100
              ),
              const SizedBox(height: 20),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: mainTextColor),
              ),
              const SizedBox(height: 8),
              Text(
                "Fill in the details to get started", 
                style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.grey)
              ),
              const SizedBox(height: 25),
              
              _buildTextField(context: context, controller: _nameController, hintText: "Full Name"),
              const SizedBox(height: 15),
              _buildTextField(context: context, controller: _emailController, hintText: "Email address", keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 15),
              _buildTextField(context: context, controller: _phoneController, hintText: "Phone Number", keyboardType: TextInputType.phone),
              const SizedBox(height: 15),
              _buildTextField(context: context, controller: _cityController, hintText: "City"),
              const SizedBox(height: 15),
              _buildTextField(context: context, controller: _passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 15),
              _buildTextField(context: context, controller: _confirmPasswordController, hintText: "Confirm Password", obscureText: true),
              
              const SizedBox(height: 35),
              
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2A945),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
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
    required BuildContext context,
    required TextEditingController controller, 
    required String hintText, 
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // High-contrast field style
        color: isDark ? const Color(0xFFF4F6F8) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: isDark 
          ? [] 
          : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
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