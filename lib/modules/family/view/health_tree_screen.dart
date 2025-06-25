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
    'عادل': 7,
    'خالد': 3,
    'نور': 5,
    'ليلى': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "كل شخص له غصن 🌿",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                height: 600,
                child: CustomPaint(
                  painter: TreePainter(familyChallenges: familyChallenges),
                ),
              ),
              const SizedBox(height: 10),
              ...familyChallenges.entries
                  .map((entry) => _treeStat(entry.key, entry.value))
                  .toList(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    familyChallenges['محمد'] =
                        (familyChallenges['محمد'] ?? 0) + 1;
                  });
                },
                child: const Text("أنجز تحدي"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _treeStat(String name, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$name: ",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            "$value تحديات",
            style: const TextStyle(color: Color(0xFF8CEE2B), fontSize: 16),
          ),
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
    final trunkPaint = Paint()..color = Colors.brown;
    final branchPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 4;
    final leafPaint = Paint()..color = const Color(0xFF8CEE2B);
    final textStyle = TextStyle(color: Colors.white, fontSize: 14);

    double trunkWidth = 20;
    double trunkHeight = 180;
    double startX = size.width / 2;
    double trunkTopY = size.height - trunkHeight;

    canvas.drawRect(
      Rect.fromLTWH(startX - trunkWidth / 2, trunkTopY, trunkWidth, trunkHeight),
      trunkPaint,
    );

    double angleStep = pi / (familyChallenges.length + 1);
    double branchLength = 100;
    int index = 0;

    for (var entry in familyChallenges.entries) {
      final angle = angleStep * (index + 1) - pi / 2;
      final Offset branchStart = Offset(startX, trunkTopY);
      final Offset branchEnd = Offset(
        branchStart.dx + cos(angle) * branchLength,
        branchStart.dy + sin(angle) * branchLength,
      );

      canvas.drawLine(branchStart, branchEnd, branchPaint);

      
      int leaves = entry.value;
      double leafRadius = 40;
      for (int i = 1; i <= leaves; i++) {
        double spreadAngle = (pi / 4);
        double angleOffset = -spreadAngle / 2 + spreadAngle * (i / (leaves + 1));
        double leafX = branchEnd.dx + cos(angleOffset) * leafRadius;
        double leafY = branchEnd.dy + sin(angleOffset) * leafRadius;
        canvas.drawCircle(Offset(leafX, leafY), 8, leafPaint);
      }

      final textSpan = TextSpan(text: entry.key, style: textStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.rtl);
      textPainter.layout();
      textPainter.paint(canvas, Offset(branchEnd.dx + 6, branchEnd.dy));
      index++;
    }
  }

  @override
  bool shouldRepaint(covariant TreePainter oldDelegate) {
    return oldDelegate.familyChallenges != familyChallenges;
  }
}
