import 'dart:ui';
import 'package:fitfam2/modules/user_setup/view/user_setup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: Stack(
        children: [
          Positioned(
            left: -340,
            bottom: -60,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  'assets/images/logo2.png',
                  height: 750,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 90),
                  const Icon(Icons.sports_handball_rounded,
                      size: 80, color: Color(0xFF8CEE2B)),
                  const SizedBox(height: 10),
                  const Text("أهلاً بك في FitFam",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  _inputField("البريد الإلكتروني"),
                  const SizedBox(height: 15),
                  _inputField("كلمة المرور", isPassword: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UserSetupScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text("تسجيل الدخول"),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignUpScreen');
                    },
                    child: const Text("ليس لديك حساب؟ أنشئ واحدًا",
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF5F757C),
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
    );
  }
}
