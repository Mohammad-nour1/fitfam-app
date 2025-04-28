import 'package:fitfam2/core/auth/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 80, color: Color(0xFF8CEE2B)),
            const SizedBox(height: 20),
            const Text("هل ترغب بالخروج؟", style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => BlocProvider.of<AppBloc>(context).add(AppEvent.login),
              child: const Text("تأكيد الخروج"),
            ),
          ],
        ),
      ),
    );
  }
}
