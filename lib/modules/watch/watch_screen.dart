import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceSetupScreen extends StatefulWidget {
  const DeviceSetupScreen({Key? key}) : super(key: key);

  @override
  State<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends State<DeviceSetupScreen> {
  bool _isGranted = false;

  @override
  void initState() {
    super.initState();
    _requestNecessaryPermissions();
  }

  Future<void> _requestNecessaryPermissions() async {
    final actStatus = await Permission.activityRecognition.request();
    final bodyStatus = await Permission.sensors.request();

    if (actStatus.isGranted && bodyStatus.isGranted) {
      setState(() => _isGranted = true);
    } else {
      if (actStatus.isPermanentlyDenied || bodyStatus.isPermanentlyDenied) {
        await openAppSettings();
      }
      setState(() => _isGranted = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(
        title: const Text("إعدادات الجهاز"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.watch,
                size: 100,
                color: _isGranted ? Colors.greenAccent : Colors.grey),
            const SizedBox(height: 16),
            Text(
              _isGranted
                  ? 'الجهاز: جاهز للربط'
                  : 'الجهاز: لم يتم الربط (الصلاحيات مرفوضة)',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.link),
              label: Text(_isGranted ? 'إعادة الربط' : 'ربط الساعة'),
              onPressed: _isGranted
                  ? _connectDevice 
                  : _requestNecessaryPermissions,
            ),
          ],
        ),
      ),
    );
  }

  void _connectDevice() {
  }
}
