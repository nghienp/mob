import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob/model/score_model.dart';

abstract class FirebaseDataSource {
  Future<List<ScoreModelResponse>> getAllData();

  Future<void> addItem(ScoreModelResponse data);

  Future<void> deleteItem(ScoreModelResponse data);

  Future<void> editUserScore(ScoreModelResponse data);
}

class FirebaseDataSourceImpl extends FirebaseDataSource {
  final _firebaseFirestore = FirebaseFirestore.instance.collection('score');

  @override
  Future<List<ScoreModelResponse>> getAllData() async {
    List<ScoreModelResponse> rs = [];
    return await _firebaseFirestore.get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> json = element.data();
        log(json.toString());
        rs.add(ScoreModelResponse.fromJson(json));
      }
      return rs;
    });
  }

  @override
  Future<void> addItem(ScoreModelResponse data) async {
    log(data.toJson().toString());
    await _firebaseFirestore.doc(data.title).set(data.toJson());
  }

  @override
  Future<void> deleteItem(ScoreModelResponse data) async {
    await _firebaseFirestore.doc(data.title).delete();
  }

  @override
  Future<void> editUserScore(ScoreModelResponse data) async {
    await _firebaseFirestore.doc(data.title).set(data.toJson());
  }
}
