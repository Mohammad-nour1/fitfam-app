import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 45,
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
              const Text("adel213@gmail.com",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 30),
              _buildInfoRow("العمر", "25"),
              _buildInfoRow("الوزن", "70 كجم"),
              _buildInfoRow("عدد أفراد العائلة", "4"),
              _buildInfoRow("نوع النشاط المفضل", "مشي"),
              const SizedBox(height: 10),
              _buildMenuTile(
                icon: Icons.support_agent,
                text: "الدعم الفني",
                onTap: () => Navigator.pushNamed(context, '/support'),
              ),
              _buildMenuTile(
                icon: Icons.emoji_events,
                text: "النقاط والشارات",
                onTap: () => Navigator.pushNamed(context, '/points'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/LoginScreen');
                },
                child: const Text(
                  "تسجيل الخروج",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
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

  Widget _buildMenuTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8CEE2B)),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white30, size: 16),
      onTap: onTap,
    );
  }
}
