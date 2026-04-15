import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = const Color(0xFFF2A945);
    final Color textColor = isDark ? Colors.white : const Color(0xFF0F2A44);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F2A44) : const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: textColor), onPressed: () => Navigator.pop(context)),
        title: Text("Security", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Update Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 30),
              _buildPasswordField("Old Password", _oldPassController, isDark),
              const SizedBox(height: 20),
              _buildPasswordField("New Password", _newPassController, isDark),
              const SizedBox(height: 20),
              _buildPasswordField("Confirm New Password", _confirmPassController, isDark, isConfirm: true),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password updated!")));
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), elevation: 0),
                  child: const Text("Change Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isDark, {bool isConfirm = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: true,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? const Color(0xFF1B3B5A) : Colors.white,
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFF2A945)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return "Field required";
            if (isConfirm && value != _newPassController.text) return "Passwords mismatch";
            return null;
          },
        ),
      ],
    );
  }
}