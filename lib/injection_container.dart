import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mob/datasource/firebase_datasource.dart';
import 'package:mob/page/params_bloc/params_bloc.dart';
import 'package:mob/page/score_bloc/score_bloc.dart';
import 'package:mob/page/user_score_bloc/user_score_bloc.dart';

//service locator
final sl = GetIt.instance;

class InjectionContainer {
  static Future<void> initServices() async {
    if (kDebugMode) {
      log('Starting services ...');
    }
    sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImpl());
    sl.registerFactory(() => ScoreBloc(firebaseDataSource: sl()));
    sl.registerFactory(() => UserScoreBloc(firebaseDataSource: sl()));
    sl.registerFactory(() => ParamsBloc());

    if (kDebugMode) {
      log('Service Successfully started ...');
    }
  }
}
