import 'package:flutter/material.dart';
import 'dart:math';

class HealthTreeScreen extends StatefulWidget {
  const HealthTreeScreen({super.key});

  @override
  _HealthTreeScreenState createState() => _HealthTreeScreenState();
}

class _HealthTreeScreenState extends State<HealthTreeScreen> {
  Map<String, int> familyChallenges = {
    'محمد': 4,
    'عادل': 5,
    'خالد': 3,
    'نور': 3,
    'ليلى': 4,
    'سارة': 3,
    'ياسين': 8
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: Column(
        children: [
          const SizedBox(height: 80),
          const SizedBox(height: 0),
          Expanded(
            child: Center(
              child: CustomPaint(
                painter: TreePainter(familyChallenges: familyChallenges),
                size: const Size(double.infinity, double.infinity),
              ),
            ),
          ),
          const SizedBox(height: 5),
          ...familyChallenges.entries
              .map((entry) => Text("${entry.key}: ${entry.value} تحديات",
                  style:
                      const TextStyle(color: Color(0xFF8CEE2B), fontSize: 16)))
              .toList(),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                familyChallenges['محمد'] = (familyChallenges['محمد'] ?? 0) + 1;
              });
            },
            icon: const Icon(Icons.check_circle),
            label: const Text("أنجز تحدي"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8CEE2B),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  final Map<String, int> familyChallenges;
  TreePainter({required this.familyChallenges});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trunkPaint = Paint()..color = Colors.brown;
    final Paint branchPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 5;
    final Paint leafPaint = Paint()..color = const Color(0xFF8CEE2B);
    const textStyle = TextStyle(color: Colors.white, fontSize: 14);

    final Offset center = Offset(size.width / 2, size.height * 0.75);
    final double trunkHeight = 150; // ✅ زاد طوله هنا

    // رسم الجذع
    canvas.drawRect(
      Rect.fromLTWH(center.dx - 10, center.dy - trunkHeight, 20, trunkHeight),
      trunkPaint,
    );

    final double radius = 130;
    final int total = familyChallenges.length;
    final double angleStep = pi / (total + -0.5);

    int index = 0;
    for (var entry in familyChallenges.entries) {
      final double angle = angleStep * (index + 1) - pi / 1;
      final Offset branchStart = Offset(center.dx, center.dy - trunkHeight);
      final Offset branchEnd = Offset(
        branchStart.dx + cos(angle) * radius,
        branchStart.dy + sin(angle) * radius,
      );

      // الغصن
      canvas.drawLine(branchStart, branchEnd, branchPaint);

      // أوراق التحديات
      final int leaves = entry.value;
      const double leafSpread = 35;

      for (int i = 0; i < leaves; i++) {
        final double leafAngle = pi / 6 * (i - leaves / 2);
        final double lx = branchEnd.dx + cos(leafAngle) * leafSpread;
        final double ly = branchEnd.dy + sin(leafAngle) * leafSpread;
        canvas.drawCircle(Offset(lx, ly), 6, leafPaint);
      }

      // اسم الشخص
      final textSpan = TextSpan(text: entry.key, style: textStyle);
      final textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.rtl);
      textPainter.layout();
      textPainter.paint(canvas, Offset(branchEnd.dx - 20, branchEnd.dy + 1));

      index++;
    }
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) =>
      oldDelegate.familyChallenges != familyChallenges;
}
