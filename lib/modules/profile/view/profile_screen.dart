
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 1),

            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),

            const SizedBox(height: 10),
            const Text(
              "عادل إمام",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("ahmad@email.com",
                style: TextStyle(color: Colors.white70)),

            const SizedBox(height: 30),

            
            _buildInfoRow("العمر", "25"),
            _buildInfoRow("الوزن", "70 كجم"),
            _buildInfoRow("عدد أفراد العائلة", "4"),
            _buildInfoRow("نوع النشاط المفضل", "مشي"),

            const SizedBox(height: 10),

            
            _buildSectionTitle("خيارات أخرى"),
            _buildMenuTile(
              icon: Icons.star,
              text: "شاراتي",
              onTap: () => Navigator.pushNamed(context, '/rewards'),
            ),
            _buildMenuTile(
              icon: Icons.settings,
              text: "الإعدادات",
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            _buildMenuTile(
              icon: Icons.support_agent,
              text: "الدعم الفني",
              onTap: () => Navigator.pushNamed(context, '/support'),
            ),

            const Spacer(),

           
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/user-setup');
              },
              child: const Text("تسجيل الخروج"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF5F757C).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Color(0xFFB2E475))),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMenuTile(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8CEE2B)),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
      onTap: onTap,
    );
  }
}
