import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
  late Timer _timer;
  late AnimationController _animationController;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeDataEvent());

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _backgrounds.length;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
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
              key: ValueKey<String>(_backgrounds[_currentIndex]),
              fit: BoxFit.cover,
              height: double.maxFinite,
            ),
          ),
          Container(
            color: const Color(0xFF012532).withOpacity(0.45),
          ),
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

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اضغط مرة اخرى للخروج من التطبيق')),
      );
      return false;
    }
    return true;
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
        automaticallyImplyLeading: false, 
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
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            final data = state.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildChallengeCard(data),
                const SizedBox(height: 20),
                _buildFamilySection(data),
                const SizedBox(height: 20),
                _buildStatsSection(),
                const SizedBox(height: 20),
                _buildBadgesSection(),
              ],
            );
          }

          if (state is HomeError) {
            return Center(
              child: Text("حدث خطأ: ${state.message}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 38),
          child: FloatingActionButton.extended(
            backgroundColor: const Color(0xFF8CEE2B),
            onPressed: () {
              Navigator.pushNamed(context, '/create-challenge');
            },
            icon: const Icon(Icons.directions_run),
            label: const Text("ابدأ تحدي جديد"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildChallengeCard(HomeData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB2E475), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 101, 121, 78).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("تحدي اليوم",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text(data.currentChallenge,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: data.progress,
            backgroundColor: Colors.white,
            color: const Color(0xFF012532),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildFamilySection(HomeData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("نشاط العائلة",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.familyActivity.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final member = data.familyActivity[index];
              return Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                  const SizedBox(height: 8),
                  Text(member.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("${member.steps} خطوة",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("شاراتي",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.emoji_events, color: const Color(0xFFB2E475)),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("إحصائياتي اليوم",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedStatCircle(
              icon: Icons.local_fire_department,
              label: "سعرات",
              value: 320,
              goal: 500,
              color: const Color(0xFFB2E475),
              size: 45.0,
            ),
            const SizedBox(width: 30),
            _buildAnimatedStatCircle(
              icon: Icons.directions_walk,
              label: "خطوات",
              value: 6500,
              goal: 10000,
              color: const Color(0xFF8CEE2B),
              size: 58.0,
            ),
            const SizedBox(width: 30),
            _buildAnimatedStatCircle(
              icon: Icons.straighten,
              label: "مسافة",
              value: 4,
              goal: 7,
              color: const Color(0xFFB2E475),
              size: 45.0,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedStatCircle({
    required IconData icon,
    required String label,
    required int value,
    required int goal,
    required Color color,
    required double size,
  }) {
    double percent = (value / goal).clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: percent),
      duration: const Duration(seconds: 2),
      builder: (context, animationValue, child) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: size,
              lineWidth: 8.0,
              percent: animationValue,
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
}
