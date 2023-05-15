import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'score_model.g.dart';

@JsonSerializable()
class ScoreModelResponse extends Equatable {
  final List<ScoreModel> data;

  const ScoreModelResponse({required this.data});

  factory ScoreModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreModelResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

@JsonSerializable()
class ScoreModel extends Equatable {
  final String name;
  final int score;

  const ScoreModel({required this.name, required this.score});

  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [name, score];
}
