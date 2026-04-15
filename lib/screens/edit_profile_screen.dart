import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: "Freeoui");
  final TextEditingController _emailController = TextEditingController(text: "freeoui@exemple.com");
  final TextEditingController _phoneController = TextEditingController(text: "+216 55 123 456");

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = const Color(0xFFF2A945);
    final Color navyColor = const Color(0xFF0F2A44);
    final Color textColor = isDark ? Colors.white : navyColor;

    return Scaffold(
      backgroundColor: isDark ? navyColor : const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.close, color: textColor), onPressed: () => Navigator.pop(context)),
        title: Text("Edit Profile", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Save", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(radius: 60, backgroundColor: primaryColor.withOpacity(0.1), child: Icon(Icons.person, size: 70, color: primaryColor)),
                  Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle), child: const Icon(Icons.camera_alt, color: Colors.white, size: 20))),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildEditField(label: "Full Name", controller: _nameController, icon: Icons.person_outline, isDark: isDark),
            const SizedBox(height: 20),
            _buildEditField(label: "Email Address", controller: _emailController, icon: Icons.email_outlined, isDark: isDark, enabled: false),
            const SizedBox(height: 20),
            _buildEditField(label: "Phone Number", controller: _phoneController, icon: Icons.phone_android_outlined, isDark: isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildEditField({required String label, required TextEditingController controller, required IconData icon, required bool isDark, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: enabled ? (isDark ? const Color(0xFF1B3B5A) : Colors.white) : (isDark ? Colors.black26 : Colors.grey[200]),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: TextStyle(color: isDark ? Colors.white : const Color(0xFF0F2A44)),
            decoration: InputDecoration(prefixIcon: Icon(icon, color: enabled ? const Color(0xFFF2A945) : Colors.grey), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 15)),
          ),
        ),
      ],
    );
  }
}