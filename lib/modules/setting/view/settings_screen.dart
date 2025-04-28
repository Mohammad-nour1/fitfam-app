import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(title: const Text("الإعدادات")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("المظهر", style: TextStyle(color: Colors.white70)),
          SwitchListTile(
            value: isDarkMode,
            onChanged: (val) => setState(() => isDarkMode = val),
            title: const Text("الوضع الليلي", style: TextStyle(color: Colors.white)),
            activeColor: const Color(0xFF8CEE2B),
          ),
          const SizedBox(height: 16),
          const Text("اللغة", style: TextStyle(color: Colors.white70)),
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            decoration: _inputDecoration(),
            dropdownColor: const Color(0xFF012532),
            items: const [
              DropdownMenuItem(value: 'العربية', child: Text('العربية', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'English', child: Text('English', style: TextStyle(color: Colors.white))),
            ],
            onChanged: (value) => setState(() => selectedLanguage = value!),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF5F757C).withOpacity(0.2),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }
}
