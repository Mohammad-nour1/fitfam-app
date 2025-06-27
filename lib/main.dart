import 'package:fitfam2/core/auth/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/auth/bloc/app_bloc.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.init();

  runApp(
    BlocProvider(
      create: (_) => AppBloc(),
      child: const FitFamApp(),
    ),
  );
}
