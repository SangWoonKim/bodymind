import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/query/bodymind_database.dart';

final dbProvider = Provider<BodymindDatabase>((ref) {
  final db = BodymindDatabase();

  ref.onDispose(() async {
    await db.close();
  });

  return db;
});

final insertServiceProvider = Provider<HealthInsertService>((ref){
  final service = HealthInsertService(ref.read(dbProvider));
  ref.onDispose(() => service.dispose());
  return service;
});