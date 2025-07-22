


/*

import 'package:bloc_test/bloc_test.dart';
import 'package:fitfam2/modules/home/bloc/home_bloc.dart';
import 'package:fitfam2/modules/home/bloc/home_event.dart';
import 'package:fitfam2/modules/home/bloc/home_state.dart';
import 'package:fitfam2/modules/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fitfam2/modules/home/view/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
  });

  tearDown(() {
    mockHomeBloc.close();
  });

  testWidgets('يظهر اسم المستخدم وإحصائيات اليوم في HomeScreen', (tester) async {
    final testStats = TodayStats(steps: 5000, calories: 200.0, distance: 3.5);
    final homeData = HomeData(
      userName: "محمد",
      currentChallenge: "تحدي 10000 خطوة",
      currentChallengeType: "مشي",
      challengeTarget: 10000,
      progress: 0.5,
      todayStats: testStats,
      familyActivity: [],
    );

    when(() => mockHomeBloc.state).thenReturn(HomeLoaded(homeData));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HomeBloc>.value(
          value: mockHomeBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.text("أهلاً محمد"), findsOneWidget);
    expect(find.text("تحدي 10000 خطوة"), findsOneWidget);
    expect(find.text("إحصائياتي اليوم"), findsOneWidget);
  });
}
*/