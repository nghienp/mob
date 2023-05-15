import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob/model/score_model.dart';

abstract class FirebaseDataSource {
  Future<List<ScoreModelResponse>> getAllData();
}

class FirebaseDataSourceImpl extends FirebaseDataSource {
  final _firebaseFirestore = FirebaseFirestore.instance.collection('score');

  @override
  Future<List<ScoreModelResponse>> getAllData() async {
    List<ScoreModelResponse> rs = [];
    return await _firebaseFirestore.get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> json = element.data();
        rs.add(ScoreModelResponse.fromJson(json));
      }
      return rs;
    });
  }
}
