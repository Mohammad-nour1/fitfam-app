import 'package:fitfam2/modules/user_setup/view/user_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  String? _error;

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const UserSetupScreen()),
          (route) => false,
        );
      } else {
        setState(() => _error = "فشل إنشاء الحساب.");
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            left: -340,
            bottom: -130,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset('assets/images/logo2.png', height: 750),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 100,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.group_add, size: 80, color: Color(0xFF8CEE2B)),
                const SizedBox(height: 10),
                const Text("قم بإنشاء حساب في FitFam",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),
                _inputField("الاسم الكامل", _nameController),
                const SizedBox(height: 15),
                _inputField("البريد الإلكتروني", _emailController),
                const SizedBox(height: 15),
                _inputField("كلمة المرور", _passwordController,
                    isPassword: true),
                const SizedBox(height: 20),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text("إنشاء الحساب"),
                ),
                const SizedBox(height: 13),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginScreen');
                  },
                  child: const Text("! هل لديك حساب بالفعل",
                      style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF5F757C),
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
