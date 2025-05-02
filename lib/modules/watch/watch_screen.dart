import 'package:flutter/material.dart';

class DeviceSetupScreen extends StatefulWidget {
  const DeviceSetupScreen({super.key});

  @override
  State<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends State<DeviceSetupScreen> {
  bool isConnected = false;
  String deviceName = "لم يتم الربط";

  void connectDevice() {
    setState(() {
      isConnected = true;
      deviceName = "SmartBand FitX";
    });
  }

  void disconnectDevice() {
    setState(() {
      isConnected = false;
      deviceName = "لم يتم الربط";
    });
  }

  void syncNow() {
    if (isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تمت مزامنة البيانات بنجاح "),
          backgroundColor: Color(0xFF8CEE2B),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF012532),
      appBar: AppBar(
        title: const Text("إعدادات الجهاز"),
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const Icon(Icons.watch, size: 100, color: Color(0xFF8CEE2B)),
              const SizedBox(height: 20),
              Text("الجهاز: $deviceName",
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isConnected ? disconnectDevice : connectDevice,
                icon: Icon(isConnected ? Icons.link_off : Icons.link),
                label: Text(isConnected ? "قطع الاتصال" : "ربط الساعة"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isConnected ? syncNow : null,
                child: const Text("مزامنة الآن"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
