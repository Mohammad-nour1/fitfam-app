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
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "اسم الفرد",
                filled: true,
                fillColor: Color(0xFF5F757C),
                hintStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
              ),
              style: const TextStyle(color: Colors.white),
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
