import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomChallengeScreen extends StatefulWidget {
  const RandomChallengeScreen({super.key});

  @override
  State<RandomChallengeScreen> createState() => _RandomChallengeScreenState();
}

class _RandomChallengeScreenState extends State<RandomChallengeScreen> {
  final List<Map<String, dynamic>> _offlineChallenges = [
    {
      "title": "امشِ 3000 خطوة",
      "type": "خطوات",
      "duration": 1,
      "reward": "شارة خضراء"
    },
    {
      "title": "اركض 1 كيلومتر",
      "type": "جري",
      "duration": 1,
      "reward": "وسام ذهبي"
    },
    {
      "title": "احرق 150 سعرة",
      "type": "سعرات",
      "duration": 1,
      "reward": "كأس إنجاز"
    },
    {
      "title": "امشِ 5000 خطوة مع أحد أفراد العائلة",
      "type": "خطوات جماعية",
      "duration": 2,
      "reward": "شارة العائلة"
    },
  ];

  Map<String, dynamic>? _selectedChallenge;

  @override
  void initState() {
    super.initState();
    _loadSavedChallenge();
  }

  Future<void> _loadSavedChallenge() async {
    final prefs = await SharedPreferences.getInstance();
    final title = prefs.getString("offline_challenge_title");
    if (title != null) {
      final challenge = _offlineChallenges.firstWhere(
        (element) => element["title"] == title,
        orElse: () => _offlineChallenges[0],
      );
      setState(() => _selectedChallenge = challenge);
    }
  }

  Future<void> _selectRandomChallenge() async {
    final random = Random();
    final challenge = _offlineChallenges[random.nextInt(_offlineChallenges.length)];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("offline_challenge_title", challenge["title"]);

    setState(() => _selectedChallenge = challenge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(title: const Text("تحدي عشوائي")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shuffle, size: 80, color: Color(0xFF8CEE2B)),
              const SizedBox(height: 20),
              if (_selectedChallenge != null) ...[
                Text(_selectedChallenge!["title"], style: const TextStyle(color: Colors.white, fontSize: 22)),
                const SizedBox(height: 10),
                Text("النوع: ${_selectedChallenge!["type"]}", style: const TextStyle(color: Colors.white)),
                Text("المدة: ${_selectedChallenge!["duration"]} يوم", style: const TextStyle(color: Colors.white)),
                Text("المكافأة: ${_selectedChallenge!["reward"]}", style: const TextStyle(color: Colors.white)),
              ] else ...[
                const Text("لم يتم اختيار تحدٍ بعد", style: TextStyle(color: Colors.white70)),
              ],
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _selectRandomChallenge,
                icon: const Icon(Icons.refresh),
                label: const Text("احصل على تحدٍ عشوائي"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
