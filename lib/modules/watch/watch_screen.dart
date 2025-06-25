import 'package:fitfam2/modules/watch/health_service.dart';
import 'package:flutter/material.dart';

class DeviceSetupScreen extends StatefulWidget {
  const DeviceSetupScreen({super.key});

  @override
  State<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends State<DeviceSetupScreen> {
  final HealthService _healthService = HealthService();

  bool isConnected = false;
  String deviceName = "لم يتم الربط";
  int steps = 0;
  int calories = 0;
  String distance = "0.0";

  Future<void> connectAndFetchData() async {
    final granted = await _healthService.requestAuthorization();
    if (granted) {
      final data = await _healthService.getTodayData();
      setState(() {
        isConnected = true;
        deviceName = "Google Fit - Mi Band";
        steps = data['steps'];
        calories = data['calories'];
        distance = data['distance'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم رفض الصلاحيات")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(title: const Text("إعدادات الجهاز")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.watch, size: 100, color: Color(0xFF8CEE2B)),
              const SizedBox(height: 20),
              Text("الجهاز: $deviceName", style: const TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: connectAndFetchData,
                icon: const Icon(Icons.link),
                label: const Text("ربط الساعة"),
              ),
              const SizedBox(height: 20),
              if (isConnected) ...[
                Text("الخطوات: $steps", style: const TextStyle(color: Colors.white)),
                Text("السعرات: $calories kcal", style: const TextStyle(color: Colors.white)),
                Text("المسافة: $distance كم", style: const TextStyle(color: Colors.white)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
