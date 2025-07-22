import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/family_bloc.dart';
import '../bloc/family_event.dart';
import '../bloc/family_state.dart';


class AddFamilyMemberScreen extends StatefulWidget {
  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<FamilyBloc>().add(LoadFamilyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(title: const Text("إضافة فرد جديد")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "ابحث عن صديق",
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (query) {
                context.read<FamilyBloc>().add(SearchUserEvent(query));
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<FamilyBloc, FamilyState>(
                builder: (context, state) {
                  if (state is FamilyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchSuccess) {
                    if (state.suggestions.isEmpty) {
                      return const Center(
                        child: Text("لا يوجد نتائج", style: TextStyle(color: Colors.white)),
                      );
                    }
                    return ListView(
                      children: state.suggestions.map((user) {
                        return ListTile(
                          title: Text(user.name, style: const TextStyle(color: Colors.white)),
                          trailing: ElevatedButton(
                            onPressed: () {
                              context.read<FamilyBloc>().add(AddFriendEvent(user.name));
                            },
                            child: const Text("إضافة"),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  if (state is FamilyLoaded) {
                    return ListView(
                      children: state.members.map((m) {
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: AssetImage(m.avatar)),
                          title: Text(m.name, style: const TextStyle(color: Colors.white)),
                          subtitle: Text("${m.steps} خطوة", style: const TextStyle(color: Colors.white70)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              context.read<FamilyBloc>().add(RemoveFamilyMemberEvent(m.id));
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
