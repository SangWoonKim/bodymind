import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'bodymind_database.g.dart';

@DriftDatabase(
  include: {'bodymind_database.drift'}
)
class BodymindDatabase extends _$BodymindDatabase{
   BodymindDatabase() : super(_openConnection());

   @override
   int get schemaVersion => 1;
}

LazyDatabase _openConnection(){
  return LazyDatabase(() async{
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'bodymind.sqlite'));
    return NativeDatabase(file);
  });
}