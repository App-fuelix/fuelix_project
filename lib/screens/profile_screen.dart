import 'package:flutter/material.dart';
import '../main.dart'; // Assurez-vous que le chemin vers main.dart est correct

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    // Détecte si le mode sombre est actif (soit par le système, soit par le bouton)
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    final Color primaryColor = const Color(0xFFF2A945);
    final Color navyColor = const Color(0xFF0F2A44);
    final Color textColor = isDark ? Colors.white : navyColor;

    return Scaffold(
      backgroundColor: isDark ? navyColor : const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          isDark ? 'assets/images/logo_fuelix_2.png' : 'assets/images/logo_fuelix.png',
          width: 100,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Header
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios, size: 20, color: textColor),
                ),
                const SizedBox(width: 10),
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // User Card (Reste blanc pour le contraste "Pop" de la maquette)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), 
                    blurRadius: 15, 
                    offset: const Offset(0, 5)
                  )
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: Icon(Icons.person, size: 50, color: primaryColor),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Freeoui",
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF0F2A44)
                    ),
                  ),
                  const Text("freeoui@exemple.com", style: TextStyle(color: Colors.grey)),
                  const Text("+216 55 123 456", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(160, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Edit Profile", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Settings List
            _buildSettingItem(
              icon: Icons.wb_sunny_outlined,
              title: "Appearance",
              isDark: isDark,
              primaryColor: primaryColor,
              trailing: Switch(
                value: isDark,
                onChanged: (val) {
                  // Change le thème globalement
                  themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                },
                activeColor: primaryColor,
              ),
            ),
            const SizedBox(height: 15),
            _buildSettingItem(
              icon: Icons.notifications_none_outlined,
              title: "Notifications",
              isDark: isDark,
              primaryColor: primaryColor,
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (val) => setState(() => _notificationsEnabled = val),
                activeColor: primaryColor,
              ),
            ),
            const SizedBox(height: 15),
            _buildSettingItem(
              icon: Icons.security_outlined,
              title: "Security",
              isDark: isDark,
              primaryColor: primaryColor,
              onTap: () => Navigator.pushNamed(context, '/security'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Log Out", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD34336),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark, primaryColor, navyColor),
    );
  }

  Widget _buildSettingItem({
    required IconData icon, 
    required String title, 
    required bool isDark, 
    required Color primaryColor,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B3B5A) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primaryColor),
            ),
            const SizedBox(width: 15),
            Text(
              title, 
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600, 
                color: isDark ? Colors.white : const Color(0xFF0F2A44)
              )
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(bool isDark, Color primary, Color navy) {
    return BottomNavigationBar(
      currentIndex: 3,
      onTap: (index) {
        if (index == 0) Navigator.pushReplacementNamed(context, '/home');
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? navy : Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Card"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}