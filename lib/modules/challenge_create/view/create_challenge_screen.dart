

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/challenge_bloc.dart';
import '../bloc/challenge_event.dart';
import '../bloc/challenge_state.dart';

class CreateChallengeScreen extends StatefulWidget {
  const CreateChallengeScreen({super.key});

  @override
  State<CreateChallengeScreen> createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {
  final _formKey = GlobalKey<FormState>();

  String challengeType = 'خطوات';
  int duration = 3;
  String reward = 'شهادة تقدير';
  final participants = <String>['أحمد', 'سارة', 'ليان'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChallengeBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFF012532),
        appBar: AppBar(
          backgroundColor: const Color(0xFF012532),
          title: const Text('إنشاء تحدي جديد'),
        ),
        body: BlocListener<ChallengeBloc, ChallengeState>(
  listener: (context, state) {
    if (state is ChallengeSuccess) {
      Navigator.pushReplacementNamed(context, '/main');
    } else if (state is ChallengeFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ: ${state.error}")),
      );
    }
  },
  child: BlocBuilder<ChallengeBloc, ChallengeState>(
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
            
              const Text("نوع التحدي:", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: challengeType,
                dropdownColor: const Color(0xFF012532),
                decoration: _inputDecoration(),
                items: ['خطوات', 'تمارين', 'وقت النشاط'].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (value) => setState(() => challengeType = value!),
              ),
              const SizedBox(height: 20),
              const Text("مدة التحدي (أيام):", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: duration,
                decoration: _inputDecoration(),
                dropdownColor: const Color(0xFF012532),
                items: List.generate(7, (i) => i + 1).map((e) {
                  return DropdownMenuItem(value: e, child: Text("$e يوم", style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (value) => setState(() => duration = value!),
              ),
              const SizedBox(height: 20),
              const Text("نوع المكافأة:", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: reward,
                decoration: _inputDecoration(),
                dropdownColor: const Color(0xFF012532),
                items: ['شهادة تقدير', 'وسام', 'هدية رمزية'].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (value) => setState(() => reward = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8CEE2B),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ChallengeBloc>().add(
                          SubmitChallengeEvent(
                            challengeType: challengeType,
                            duration: duration,
                            reward: reward,
                          ),
                        );
                  }
                },
                child: const Text("ابدأ التحدي"),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF5F757C).withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
