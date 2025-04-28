import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/auth/bloc/app_bloc.dart';
import 'app/app.dart'; 

void main() {
  runApp(BlocProvider(
    create: (_) => AppBloc(),
    child: const FitFamApp(), 
  ));
}
