import 'package:health/health.dart';

class HealthService {
  final Health _health = Health();

  final types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_DELTA,
  ];

  final permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  Future<bool> requestAuthorization() async {
    final hasPermissions =
        await _health.hasPermissions(types, permissions: permissions);
    if (!hasPermissions!) {
      return await _health.requestAuthorization(
        types,
        permissions: [
          HealthDataAccess.READ,
          HealthDataAccess.READ,
          HealthDataAccess.READ
        ],
      );
    }
    return true;
  }

  Future<Map<String, dynamic>> getTodayData() async {
    final now = DateTime.now();

    final startOfDay = DateTime(now.year, now.month, now.day);
    final data = await _health.getHealthDataFromTypes(
      types: types,
      startTime: startOfDay,
      endTime: now,
    );

    double _sum(HealthDataType type) => data.where((d) => d.type == type).fold(
        0.0,
        (sum, d) =>
            sum +
            (d.value is int ? (d.value as int).toDouble() : d.value as double));

    return {
      'steps': _sum(HealthDataType.STEPS).round(),
      'calories': _sum(HealthDataType.ACTIVE_ENERGY_BURNED).round(),
      'distance':
          (_sum(HealthDataType.DISTANCE_DELTA) / 1000).toStringAsFixed(2),
    };
  }
}
