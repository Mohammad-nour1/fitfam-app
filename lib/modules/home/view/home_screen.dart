import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fitfam2/core/notifications/notifications.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<String> _backgrounds = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
  ];

  int _currentIndex = 0;
  late Timer _bgTimer;
  late AnimationController _animationController;
  late StreamSubscription<StepCount> _stepSub;
  int _initialSteps = 0;
  bool _challengeCompleted = false;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(LoadHomeDataEvent());

    _requestNotificationPermission();

    _bgTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _backgrounds.length;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    Timer(const Duration(seconds: 120), () {
      NotificationHelper.showNotification(
        title: "💪 تحدي جديد",
        body: "أكمل صديقك أحمد تحديًا جديدًا، هل أنت مستعد؟",
      );
    });

    _requestActivityPermissions();
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  Future<void> _requestActivityPermissions() async {
    final activityGranted =
        await Permission.activityRecognition.request().isGranted;
    final sensorsGranted = await Permission.sensors.request().isGranted;

    if (activityGranted && sensorsGranted) {
      _startPedometerStream();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('الرجاء السماح للتطبيق بقراءة خطوات المشي')),
      );
    }
  }

  void _startPedometerStream() {
    _stepSub = Pedometer.stepCountStream.listen(
      (StepCount event) {
        final current = event.steps;
        if (_initialSteps == 0) _initialSteps = current;
        final today = current - _initialSteps;
        final dist = today / 1312;
        final cal = today * 0.04;

        context.read<HomeBloc>().add(
              UpdateStepDataEvent(
                todayStats:
                    TodayStats(steps: today, distance: dist, calories: cal),
              ),
            );

        if (today >= 10 && !_challengeCompleted) {
          _challengeCompleted = true;
          NotificationHelper.showNotification(
            title: "🎉 مبروك!",
            body: "لقد أكملت تحدي 10 خطوات!",
          );
        }
      },
      onError: (e) {
        debugPrint('Pedometer Error: $e');
      },
    );
  }

  @override
  void dispose() {
    _bgTimer.cancel();
    _animationController.dispose();
    _stepSub.cancel();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اضغط مرة أخرى للخروج')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              _backgrounds[_currentIndex],
              key: ValueKey(_backgrounds[_currentIndex]),
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),
          Container(color: const Color(0xFF012532).withOpacity(0.45)),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(color: Colors.transparent),
            ),
          ),
          const _HomeContent(),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return Text("أهلاً ${state.data.userName}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold));
            }
            return const Text("جاري التحميل...",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.watch, color: Color(0xFF8CEE2B)),
            tooltip: 'ربط الساعة',
            onPressed: () => Navigator.pushNamed(context, '/device-setup'),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeLoaded) {
            final data = state.data;
            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildChallengeCard(data),
                const SizedBox(height: 15),
                _buildStatsSection(data.todayStats, data.challengeTarget),
                const SizedBox(height: 15),
                _buildFamilySection(data),
                const SizedBox(height: 20),
                _buildBadgesSection(),
              ],
            );
          }
          if (state is HomeError) {
            return Center(
                child: Text("خطأ: ${state.message}",
                    style: const TextStyle(color: Colors.white)));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildChallengeCard(HomeData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB2E475), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("تحدي اليوم",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 8),
          Text(data.currentChallenge,
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value:
                (data.todayStats.steps / data.challengeTarget).clamp(0.0, 1.0),
            backgroundColor: Colors.white,
            color: const Color(0xFF012532),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(TodayStats stats, int challengeTarget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("إحصائياتي اليوم",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedStatCircle(Icons.local_fire_department, "سعرات",
                stats.calories.toInt(), 500, const Color(0xFFB2E475), 45),
            const SizedBox(width: 10),
            _buildAnimatedStatCircle(Icons.directions_walk, "خطوات",
                stats.steps, 10000, const Color(0xFF8CEE2B), 59),
            const SizedBox(width: 10),
            _buildAnimatedStatCircle(Icons.straighten, "مسافة",
                stats.distance.toInt(), 7, const Color(0xFFB2E475), 45),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedStatCircle(IconData icon, String label, int value,
      int goal, Color color, double size) {
    final percent = (value / goal).clamp(0.0, 1.0);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: percent),
      duration: const Duration(seconds: 2),
      builder: (context, anim, _) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: size,
              lineWidth: 8,
              percent: anim,
              center: Icon(icon, size: size / 1.5, color: color),
              progressColor: color,
              backgroundColor: Colors.white24,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
            Text("$value",
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        );
      },
    );
  }

  Widget _buildFamilySection(HomeData data) {
    final members = data.familyActivity.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("نشاط العائلة",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 8,
          children: members.map((member) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(member.avatar),
                ),
                const SizedBox(height: 5),
                Text(member.name,
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
                Text("${member.distance.toStringAsFixed(1)} كم",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBadgesSection() {
    final badgeLabels = ['المثابرة', 'الانضباط', 'الإنجاز'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("شاراتي",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(badgeLabels.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.emoji_events,
                        color: const Color(0xFFB2E475)),
                  ),
                  const SizedBox(height: 4),
                  Text(badgeLabels[i],
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
