// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreModelResponse _$ScoreModelResponseFromJson(Map<String, dynamic> json) =>
    ScoreModelResponse(
      title: json['title'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ScoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScoreModelResponseToJson(ScoreModelResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'title': instance.title,
    };

ScoreModel _$ScoreModelFromJson(Map<String, dynamic> json) => ScoreModel(
      name: json['name'] as String,
      score: json['score'] as int,
    );

Map<String, dynamic> _$ScoreModelToJson(ScoreModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
    };
