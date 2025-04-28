
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/challenge_details_bloc.dart';
import '../bloc/challenge_details_event.dart';
import '../bloc/challenge_details_state.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  final int challengeId;

  const ChallengeDetailsScreen({super.key, required this.challengeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChallengeDetailsBloc()..add(LoadChallengeDetailsEvent(challengeId)),
      child: Scaffold(
        backgroundColor: const Color(0xFF012532),
        appBar: AppBar(
          backgroundColor: const Color(0xFF012532),
          title: const Text("تفاصيل التحدي"),
        ),
        body: BlocBuilder<ChallengeDetailsBloc, ChallengeDetailsState>(
          builder: (context, state) {
            if (state is ChallengeDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChallengeDetailsLoaded) {
              final data = state.details;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      data.description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),

                    LinearProgressIndicator(
                      value: data.progress,
                      backgroundColor: Colors.white,
                      color: const Color(0xFF8CEE2B),
                      minHeight: 10,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      "المدة المتبقية: ${data.remainingDays} يوم",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    const Text("المشاركون", style: TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 8),

                    ...data.participants.map((member) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5F757C).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              member.name,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "${member.steps} خطوة",
                              style: const TextStyle(color: Color(0xFFB2E475)),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8CEE2B),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                      },
                      child: const Text("تحديث التقدم الخاص بي"),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5F757C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("رجوع"),
                    ),
                  ],
                ),
              );
            } else if (state is ChallengeDetailsError) {
              return Center(
                child: Text(
                  "حدث خطأ: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
