import 'package:flutter/material.dart';


class FamilyChallengeScreen extends StatefulWidget {
  const FamilyChallengeScreen({super.key});

  @override
  State<FamilyChallengeScreen> createState() => _FamilyChallengeScreenState();
}

class _FamilyChallengeScreenState extends State<FamilyChallengeScreen> {
  final _formKey = GlobalKey<FormState>();

  String _challengeType = 'مشي';
  int _durationDays = 3;
  final _goalController = TextEditingController();

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(
        title: const Text("إنشاء تحدي عائلي"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("نوع التحدي:", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _challengeType,
                dropdownColor: const Color(0xFF012532),
                decoration: _inputDecoration(),
                items: ['مشي', 'جري', 'سباحة', 'تمارين منزلية'].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _challengeType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("مدة التحدي بالأيام:", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _durationDays,
                dropdownColor: const Color(0xFF012532),
                decoration: _inputDecoration(),
                items: List.generate(7, (i) => i + 1).map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text("$e يوم", style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _durationDays = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("الهدف (عدد الخطوات):", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(hintText: "مثال: 10000"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال عدد الخطوات";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // هنا يفترض ترسل التحدي إلى أفراد العائلة كلهم
                    // حاليا فقط نظهر رسالة نجاح مؤقتة
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إنشاء التحدي العائلي بنجاح! 🎯'),
                        backgroundColor: Color(0xFF8CEE2B),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("ابدأ التحدي"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color(0xFF5F757C).withOpacity(0.3),
      hintStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
