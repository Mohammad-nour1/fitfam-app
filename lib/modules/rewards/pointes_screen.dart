import 'package:flutter/material.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalPoints = 120;

    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(title: const Text("نقاطي")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.star, size: 80, color: Color(0xFF8CEE2B)),
            const SizedBox(height: 20),
            Text(
              "$totalPoints نقطة",
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.white38, height: 40),
            const Text("كيفية الحصول على النقاط:",
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            _pointRule("👣 1000 خطوة", 10),
            _pointRule("🏆 إكمال تحدي", 50),
            _pointRule("🤝 دعوة فرد عائلة", 30),
            _pointRule("🔥 يوم نشيط بالكامل", 20),
          ],
        ),
      ),
    );
  }

  Widget _pointRule(String title, int pts) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          Text("+$pts نقطة", style: const TextStyle(color: Color(0xFFB2E475))),
        ],
      ),
    );
  }
}
