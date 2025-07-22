import 'package:fitfam2/core/auth/supabase_service.dart';
import 'package:fitfam2/core/notifications/notifications.dart';
import 'package:fitfam2/modules/family/bloc/family_bloc.dart';
import 'package:fitfam2/modules/family/bloc/family_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/auth/bloc/app_bloc.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => AppBloc(),
        ),
        BlocProvider<FamilyBloc>(
          create: (_) => FamilyBloc()..add(LoadFamilyEvent()),
        ),
      ],
      child: const FitFamApp(),
    ),
  );
}
