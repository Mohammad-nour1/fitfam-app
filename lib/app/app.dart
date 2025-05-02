import 'package:fitfam2/modules/family/view/family_activity_screen.dart';
import 'package:fitfam2/modules/family/view/health_tree_screen.dart';
import 'package:fitfam2/modules/rewards/pointes_screen.dart';
import 'package:fitfam2/modules/watch/watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/auth/bloc/app_bloc.dart';
import '../modules/support/view/support_screen.dart';
import '../modules/rewards/view/rewards_screen.dart';
import '../modules/user_setup/view/user_setup_screen.dart';
import '../modules/challenge_create/view/create_challenge_screen.dart';
import '../modules/challenge_details/view/challenge_details_screen.dart';
import '../core/navigation/main_navigation_screen.dart';
import '../core/auth/view/splash_screen.dart';
import '../core/auth/view/login_screen.dart';
import '../core/auth/view/signup_screen.dart';
import '../core/auth/view/logout_screen.dart';

class FitFamApp extends StatelessWidget {
  const FitFamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, String>(
      builder: (context, currentRoute) {
        return MaterialApp(
          title: 'FitFam Challenge',
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar', ''),
          supportedLocales: const [Locale('ar', ''), Locale('en', '')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            fontFamily: 'Tajawal',
            scaffoldBackgroundColor: const Color(0xFF012532),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF012532),
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8CEE2B),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF012532),
              selectedItemColor: Color(0xFF8CEE2B),
              unselectedItemColor: Color(0xFF5F757C),
            ),
          ),
          initialRoute: currentRoute,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/SplashScreen':
                return MaterialPageRoute(builder: (_) => const SplashScreen());
              case '/LoginScreen':
                return MaterialPageRoute(builder: (_) => const LoginScreen());
              case '/SignUpScreen':
                return MaterialPageRoute(builder: (_) => const SignUpScreen());
              case '/LogoutScreen':
                return MaterialPageRoute(builder: (_) => const LogoutScreen());
              case '/user-setup':
                return MaterialPageRoute(builder: (_) => const UserSetupScreen());
              case '/main':
                return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
              case '/create-challenge':
                return MaterialPageRoute(builder: (_) => const CreateChallengeScreen());
              case '/rewards':
                return MaterialPageRoute(builder: (_) => const RewardsScreen());
              case '/challenge-details':
                final challengeId = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => ChallengeDetailsScreen(challengeId: challengeId),
                );
              case '/health-tree':
                return MaterialPageRoute(builder: (_) => const HealthTreeScreen());
                case '/points':
                return MaterialPageRoute(builder: (_) => const PointsScreen());
                case '/family-activity':
                return MaterialPageRoute(builder: (_) => const FamilyActivityScreen());
              case '/device-setup':
                return MaterialPageRoute(builder: (_) => const DeviceSetupScreen());
    
              case '/support':
                return MaterialPageRoute(builder: (_) => const SupportScreen());
              default:
                return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
            }
          },
        
          home: BlocListener<AppBloc, String>(
            listener: (context, route) {
              if (route != "/SplashScreen") {
                Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
              }
            },
            child: const SplashScreen(), 
          ),
        );
      },
    );
  }
}
