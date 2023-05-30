import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'score_model.g.dart';

@JsonSerializable()
class ScoreModelResponse extends Equatable {
  final List<ScoreModel> data;
  final String title;

  const ScoreModelResponse({required this.title, required this.data});

  factory ScoreModelResponse.fromJson(Map<String, dynamic> json) => _$ScoreModelResponseFromJson(json);

  Map<String, dynamic> toJson() => {'title': title, 'data': data.map((e) => e.toJson()).toList()};

  @override
  List<Object?> get props => [data, title];
}

@JsonSerializable()
class ScoreModel extends Equatable {
  final String name;
  final int score;

  const ScoreModel({required this.name, required this.score});

  factory ScoreModel.fromJson(Map<String, dynamic> json) => _$ScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreModelToJson(this);

  @override
  List<Object?> get props => [name, score];
}
