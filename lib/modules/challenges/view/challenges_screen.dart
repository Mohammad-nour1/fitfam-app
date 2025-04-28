
import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = [
      {'title': 'تحدي 10000 خطوة', 'daysLeft': 2, 'participants': 5},
      {'title': 'تمارين 30 دقيقة يوميًا', 'daysLeft': 4, 'participants': 3},
      {'title': 'تحدي العائلة: مشي جماعي', 'daysLeft': 1, 'participants': 6},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final item = challenges[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/challenge-details', arguments: 1); // ID افتراضي
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF5F757C).withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'].toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("متبقي: ${item['daysLeft']} يوم", style: const TextStyle(color: Colors.white70)),
                      Text("المشاركين: ${item['participants']}", style: const TextStyle(color: Color(0xFFB2E475))),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
