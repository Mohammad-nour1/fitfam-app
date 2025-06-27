import 'package:fitfam2/modules/family/bloc/family_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/family_bloc.dart';
import '../bloc/family_event.dart';
import '../model/family_member.dart';
import 'dart:math';

class AddFamilyMemberScreen extends StatefulWidget {
  const AddFamilyMemberScreen({super.key});

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  final _nameController = TextEditingController();
  String _selectedAvatar = 'assets/images/user.png'; // صورة افتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(
        title: const Text("إضافة فرد جديد"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
           TextField(
  decoration: const InputDecoration(
    hintText: "ابحث عن صديق",
    hintStyle: TextStyle(color: Colors.white70),
    fillColor: Colors.white10,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
  ),
  style: const TextStyle(color: Colors.white),
  onChanged: (query) {
    context.read<FamilyBloc>().add(SearchUserEvent(query));
  },
),
BlocBuilder<FamilyBloc, FamilyState>(
  builder: (context, state) {
    if (state is SearchSuccess) {
      if (state.suggestions.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "لا يوجد نتائج لهذا الاسم",
            style: TextStyle(color: Colors.white70),
          ),
        );
      }

      return Column(
        children: state.suggestions.map((user) {
          return ListTile(
            title: Text(user.name, style: const TextStyle(color: Colors.white)),
            subtitle: Text(user.email, style: const TextStyle(color: Colors.white70)),
            trailing: ElevatedButton(
              onPressed: () {
                final member = FamilyMember(
                  id: user.id.toString(),
                  name: user.name,
                  avatar: 'assets/images/user.png',
                  steps: 0,
                  progress: 0,
                );
                context.read<FamilyBloc>().add(AddFamilyMemberEvent(member));
                Navigator.pop(context);
              },
              child: const Text("إضافة"),
            ),
          );
        }).toList(),
      );
    } else if (state is FamilyLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: CircularProgressIndicator(),
      );
    }

    return const SizedBox.shrink();
  },
),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final member = FamilyMember(
                  id: Random().nextInt(10000).toString(),
                  name: _nameController.text.trim(),
                  avatar: _selectedAvatar,
                  steps: 0,
                  progress: 0,
                );
                context.read<FamilyBloc>().add(AddFamilyMemberEvent(member));
                Navigator.pop(context);
              },
              child: const Text("أضف الفرد"),
            ),
          ],
        ),
      ),
    );
  }
}
