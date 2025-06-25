import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/family_bloc.dart';
import '../bloc/family_state.dart';
import '../bloc/family_event.dart';
import '../model/family_member.dart';
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
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(member.avatar),
                      ),
                      title: Text(member.name,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text("${member.steps} خطوة",
                          style: const TextStyle(color: Color(0xFFB2E475))),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${(member.progress * 100).toInt()}%",
                              style: const TextStyle(color: Colors.white)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            tooltip: 'حذف الفرد',
                            onPressed: () {
                              _confirmDelete(context, member);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("لا يوجد أفراد مضافين بعد",
                    style: TextStyle(color: Colors.white)),
              );
            }
          },
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50, right: 45),
            child: FloatingActionButton.extended(
              backgroundColor: const Color(0xFF8CEE2B),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddFamilyMemberScreen()),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text(
                "َ أضف فرد",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, FamilyMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: Text("هل تريد حذف ${member.name} من العائلة؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              context.read<FamilyBloc>().add(RemoveFamilyMemberEvent(member.id));
              Navigator.pop(context);
            },
            child: const Text("نعم، احذف"),
          ),
        ],
      ),
    );
  }
}
