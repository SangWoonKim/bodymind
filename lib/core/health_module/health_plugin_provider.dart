import 'package:bodymind/core/health_module/health_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final healthProvider = Provider<HealthService>((ref) {
  final healthModuleInstance = HealthService();
  return healthModuleInstance;
});