
import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = [
      {
        'name': 'خطاك الأولى',
        'description': 'أكمل أول تحدي لك',
        'icon': Icons.emoji_events,
        'unlocked': true,
      },
      {
        'name': 'مئة ألف خطوة',
        'description': 'اجمع 100,000 خطوة',
        'icon': Icons.directions_walk,
        'unlocked': false,
      },
      {
        'name': 'عائلة نشيطة',
        'description': 'شارك مع 4 أفراد عائلة أو أكثر',
        'icon': Icons.group,
        'unlocked': true,
      },
    ];

    final total = rewards.length;
    final unlocked = rewards.where((e) => e['unlocked'] == true).length;

    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              "شاراتك",
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "لقد حصلت على $unlocked من أصل $total شارة!",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: rewards.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  final isUnlocked = reward['unlocked'] as bool;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? const Color(0xFFB2E475).withOpacity(0.8)
                          : const Color(0xFF5F757C).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          reward['icon'] as IconData,
                          color: isUnlocked ? Colors.black : Colors.white54,
                          size: 36,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reward['name'].toString(),
                                style: TextStyle(
                                  color: isUnlocked ? Colors.black : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                reward['description'].toString(),
                                style: TextStyle(
                                  color: isUnlocked ? Colors.black87 : Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isUnlocked)
                          const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
