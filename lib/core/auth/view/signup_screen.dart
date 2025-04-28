import 'dart:ui'; 
import 'package:flutter/material.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: Stack(
        children: [
          
          Positioned(
            left: -390, 
            bottom: 30,
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Opacity(
                opacity: 0.7, 
                child: Image.asset(
                  'assets/images/logo2.png', 
                 
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
                  const SizedBox(height: 100),
                  const Icon(Icons.group_add,
                      size: 80, color: Color(0xFF8CEE2B)),
                  const Text("قم بإنشاء حساب في FitFam",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  _inputField("الاسم الكامل"),
                  const SizedBox(height: 15),
                  _inputField("البريد الإلكتروني"),
                  const SizedBox(height: 15),
                  _inputField("كلمة المرور", isPassword: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      
                      Navigator.pushNamed(context, '/LoginScreen');
                    },
                    child: const Text("إنشاء الحساب"),
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
