import 'package:fitfam2/modules/family/view/add_family_member_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/family_bloc.dart';
import '../bloc/family_event.dart';
import '../bloc/family_state.dart';

class FamilyActivityScreen extends StatelessWidget {
  const FamilyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = FamilyBloc();
        bloc.add(LoadFamilyEvent());
        return bloc;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF012532),
        appBar: AppBar(title: const Text("قائمة الأصدقاء")),
        body: BlocBuilder<FamilyBloc, FamilyState>(
          builder: (context, state) {
            if (state is FamilyLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FamilyLoaded && state.members.isNotEmpty) {
              return RefreshIndicator(
                color: const Color(0xFF8CEE2B),
                backgroundColor: const Color(0xFF012532),
                onRefresh: () async {
                  context.read<FamilyBloc>().add(LoadFamilyEvent());
                  await context
                      .read<FamilyBloc>()
                      .stream
                      .firstWhere((s) => s is! FamilyLoading);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.members.length,
                  itemBuilder: (ctx, i) {
                    final m = state.members[i];
                    return Card(
                      color: const Color(0xFF5F757C).withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading:
                            CircleAvatar(backgroundImage: AssetImage(m.avatar)),
                        title: Text(m.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text("${m.steps} خطوة",
                            style: const TextStyle(color: Color(0xFFB2E475))),
                        trailing: Text("${(m.progress * 100).toInt()}%",
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              );
            }
            return RefreshIndicator(
              color: const Color(0xFF8CEE2B),
              backgroundColor: const Color(0xFF012532),
              onRefresh: () async {
                context.read<FamilyBloc>().add(LoadFamilyEvent());
                await context
                    .read<FamilyBloc>()
                    .stream
                    .firstWhere((s) => s is! FamilyLoading);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(
                    child: Text("لا يوجد أفراد مضافين",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            );
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
                  MaterialPageRoute(builder: (_) => AddFamilyMemberScreen()),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text(
                "أضف فرد",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
