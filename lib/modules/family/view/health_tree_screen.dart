import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class HealthTreeScreen extends StatefulWidget {
  const HealthTreeScreen({super.key});

  @override
  _HealthTreeScreenState createState() => _HealthTreeScreenState();
}

class _HealthTreeScreenState extends State<HealthTreeScreen> {
  final List<int> _memberIds = [1, 2, 3, 4, 5, 6, 7, 9];

  Map<String, int>? _familyChallenges;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFamilyChallenges();
  }

  Future<void> _loadFamilyChallenges() async {
    final Map<String, int> results = {};
    try {
      for (var id in _memberIds) {
        final url = Uri.parse(
            'https://fitfam-backend-production.up.railway.app/api/family-tree-features/show/$id');
        final resp = await http.get(url);
        if (resp.statusCode == 200) {
          final jsonBody = jsonDecode(resp.body);
          final name = jsonBody['user_name'] as String;
          final completed = jsonBody['challenges_completed'] as int;
          results[name] = completed;
        } else {
          throw Exception('Status ${resp.statusCode}');
        }
      }
      setState(() {
        _familyChallenges = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(
        title:
            const Text("شجرة العائلة الصحية", style: TextStyle(fontSize: 18)),
        backgroundColor: const Color(0xFF012532),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Text(
                      'خطأ في التحميل:\n$_error',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomPaint(
                            painter: TreePainter(
                                familyChallenges: _familyChallenges!),
                            size: Size.infinite,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            ExpansionTile(
                              collapsedTextColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              iconColor: Colors.white,
                              textColor: const Color(0xFF8CEE2B),
                              title: const Text(
                                "عرض تحديات كل فرد",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              children: _familyChallenges!.entries.map((entry) {
                                return ListTile(
                                  title: Text(
                                    "${entry.key}: ${entry.value} تحديات",
                                    style: const TextStyle(
                                        color: Color(0xFF8CEE2B)),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _familyChallenges!['محمد'] =
                                      (_familyChallenges!['محمد'] ?? 0) + 1;
                                });
                              },
                              icon: const Icon(Icons.check_circle),
                              label: const Text("أنجز تحدي"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8CEE2B),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
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

    final Offset center = Offset(size.width / 2, size.height * 0.95);
    const double trunkHeight = 130;

    canvas.drawRect(
      Rect.fromLTWH(center.dx - 10, center.dy - trunkHeight, 20, trunkHeight),
      trunkPaint,
    );

    const double radius = 130;
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

      canvas.drawLine(branchStart, branchEnd, branchPaint);

      final int leaves = entry.value;
      const double leafSpread = 35;

      for (int i = 0; i < leaves; i++) {
        final double leafAngle = pi / 6 * (i - leaves / 2);
        final double lx = branchEnd.dx + cos(leafAngle) * leafSpread;
        final double ly = branchEnd.dy + sin(leafAngle) * leafSpread;
        canvas.drawCircle(Offset(lx, ly), 6, leafPaint);
      }

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
