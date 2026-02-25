import 'package:bodymind/core/health_module/health_service.dart';
import 'package:bodymind/core/service/repository/health_repository.dart';
import 'package:bodymind/core/service/repository/health_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/health_insert_service.dart';
import 'database/query/bodymind_database.dart';

final dbProvider = Provider<BodymindDatabase>((ref) {
  final db = BodymindDatabase();

  ref.onDispose(() async {
    await db.close();
  });

  return db;
});

final healthServiceProvider = Provider<HealthService>((ref) {
  final module = HealthService();

  return module;
});

final insertRepoProvider = Provider<HealthRepository>((ref) {
  final repo = HealthRepositoryImpl(ref.read(healthServiceProvider));

  return repo;
});

final insertServiceProvider = Provider<HealthInsertService>((ref){
  final db = ref.read(dbProvider);
  final repo = ref.read(insertRepoProvider);
  final service = HealthInsertService.init(repo: repo, db: db);
  service.runService();
  service.insertData();

  ref.onDispose(service.pauseService);
  return service;
});