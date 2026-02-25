import 'dart:async';

import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/features/main_feature/home/domain/entity/feature_entity.dart';
import 'package:bodymind/features/main_feature/home/domain/entity/home_feature_entity.dart';
import 'package:bodymind/features/main_feature/home/domain/repository/home_db_repository.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';
import 'package:common_mutiple_health/entity/model/base/base_dynamic_model.dart';

class HomeUsecase {
  final HomeDbRepository repository;
  HomeUsecase(this.repository);

  // Future<void> requestPermission() async{
  //   await repository.requestPermission();
  //   return;
  // }

  Stream<FeatureEntity> selectAllParallelEmitAsDone(int previousDays) {
    final controller = StreamController<FeatureEntity>();
    var remaining = 4;

    void done() {
      remaining--;
      if (remaining == 0) controller.close();
    }

    void emitFeature(DataCatalog catalog, Future<List<FeatureModel>?> future) {
      future
          .then((model) {
        controller.add(
          FeatureEntity(
            category: catalog,
            featureLst: _toFeatureList(catalog, model),
          ),
        );
      })
          .catchError(controller.addError)
          .whenComplete(done);
    }

    emitFeature(DataCatalog.Act, repository.loadSavedActData(previousDays));
    emitFeature(DataCatalog.Heart, repository.loadSavedHeartData(previousDays));
    emitFeature(DataCatalog.Sleep, repository.loadSavedSleepData(previousDays));
    emitFeature(DataCatalog.Exercise, repository.loadSavedExerciseData(previousDays));

    return controller.stream;
  }

  List<HomeFeatureEntity> _toFeatureList(
      DataCatalog catalog,
      List<FeatureModel>? model,
      ) {

    if (model == null) return const [];
    return model.map((e) {
      return HomeFeatureEntity(feature: catalog, featureData: e);
    }).toList();
  }
}