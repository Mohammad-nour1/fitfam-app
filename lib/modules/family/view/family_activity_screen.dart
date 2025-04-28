import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/family_bloc.dart';
import '../bloc/family_state.dart';

import 'add_family_member_screen.dart';

class FamilyActivityScreen extends StatelessWidget {
  const FamilyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FamilyBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFF012532),
        appBar: AppBar(
          title: const Text("نشاط العائلة"),
        ),
        body: BlocBuilder<FamilyBloc, FamilyState>(
          builder: (context, state) {
            if (state is FamilyLoaded && state.members.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  final member = state.members[index];
                  return Card(
                    color: const Color(0xFF5F757C).withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(backgroundImage: AssetImage(member.avatar)),
                      title: Text(member.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text("${member.steps} خطوة", style: const TextStyle(color: Color(0xFFB2E475))),
                      trailing: Text("${(member.progress * 100).toInt()}%", style: const TextStyle(color: Colors.white)),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("لا يوجد أفراد مضافين بعد", style: TextStyle(color: Colors.white)),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF8CEE2B),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFamilyMemberScreen()));
          },
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}
