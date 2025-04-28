import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_setup_bloc.dart';
import '../bloc/user_setup_event.dart';
import '../bloc/user_setup_state.dart';

class UserSetupScreen extends StatelessWidget {
  const UserSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserSetupBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إعداد حسابك الشخصي'),
        ),
        body: const UserSetupForm(),
      ),
    );
  }
}

class UserSetupForm extends StatefulWidget {
  const UserSetupForm({super.key});

  @override
  State<UserSetupForm> createState() => _UserSetupFormState();
}

class _UserSetupFormState extends State<UserSetupForm> {
  final _formKey = GlobalKey<FormState>();

  int familyMembers = 1;
  String ageGroup = '18-30';
  String activityType = 'مشي';
  String goal = 'تحسين اللياقة';

  final dropdownTextStyle = const TextStyle(color: Colors.white); 

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSetupBloc, UserSetupState>(
      listener: (context, state) {
        if (state is UserSetupSuccess) {
          Navigator.pushReplacementNamed(context, '/main');
        } else if (state is UserSetupFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("خطأ: ${state.error}")),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("عدد أفراد العائلة:",
                  style: TextStyle(color: Colors.white)),
              DropdownButtonFormField<int>(
                dropdownColor: const Color(0xFF012532), 
                value: familyMembers,
                style: dropdownTextStyle,
                items: List.generate(10, (index) {
                  final value = index + 1;
                  return DropdownMenuItem(
                    value: value,
                    child: Text("$value أفراد", style: dropdownTextStyle),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    familyMembers = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("الفئة العمرية:",
                  style: TextStyle(color: Colors.white)),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF012532),
                value: ageGroup,
                style: dropdownTextStyle,
                items: ['أقل من 18', '18-30', '31-50', 'أكثر من 50'].map((e) {
                  return DropdownMenuItem(
                      value: e, child: Text(e, style: dropdownTextStyle));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    ageGroup = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("نوع النشاط المفضل:",
                  style: TextStyle(color: Colors.white)),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF012532),
                value: activityType,
                style: dropdownTextStyle,
                items: ['مشي', 'جري', 'سباحة', 'رياضة منزلية'].map((e) {
                  return DropdownMenuItem(
                      value: e, child: Text(e, style: dropdownTextStyle));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    activityType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("هدفك الأساسي:",
                  style: TextStyle(color: Colors.white)),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF012532),
                value: goal,
                style: dropdownTextStyle,
                items:
                    ['تحسين اللياقة', 'فقدان الوزن', 'زيادة النشاط'].map((e) {
                  return DropdownMenuItem(
                      value: e, child: Text(e, style: dropdownTextStyle));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    goal = value!;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<UserSetupBloc>().add(
                          SubmitUserSetupEvent(
                            familyMembers: familyMembers,
                            ageGroup: ageGroup,
                            activityType: activityType,
                            goal: goal,
                          ),
                        );
                  }
                },
                child: const Text("ابدأ التحدي الأول"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
