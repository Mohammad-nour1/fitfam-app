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
      appBar: AppBar(title: const Text("التحديات")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final item = challenges[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/challenge-details', arguments: 1);
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
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("متبقي: ${item['daysLeft']} يوم",
                          style: const TextStyle(color: Colors.white70)),
                      Text("المشاركين: ${item['participants']}",
                          style: const TextStyle(color: Color(0xFF8CEE2B))),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8CEE2B),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            backgroundColor: const Color(0xFF1E3D40),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("اختر نوع التحدي",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 20),
                    _buildOptionCard(
                      context: context,
                      label: "تحدي أوفلاين",
                      icon: Icons.cloud_off,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/random-challenge');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOptionCard(
                      context: context,
                      label: "تحدي أونلاين",
                      icon: Icons.cloud_done,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/create-challenge');
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.directions_run),
        label: const Text("ابدأ تحدي جديد"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF8CEE2B),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
