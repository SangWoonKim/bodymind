import 'dart:async';

import 'package:bodymind/core/storage/database/query/bodymind_database.dart';

class HealthInsertService {
  final BodymindDatabase db;
  Timer? _refreshTimer;
  bool _isRunning = false;

  HealthInsertService(this.db);

  void runService(){
    if(_isRunning) return;
    _isRunning = true;

    _refreshTimer = Timer.periodic(Duration(minutes: 10), (_) async{
      await insertData();
    });
  }

  Future<void> insertData() async{

  }
}