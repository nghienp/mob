part of 'score_bloc.dart';

@immutable
abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class GetScoreLoading extends ScoreState {
  // final List<ScoreModelResponse> rs;
  //
  // GetScoreLoading({required this.rs});
}

class GetScoreSuccess extends ScoreState {
  final List<ScoreModelResponse> rs;

  GetScoreSuccess({required this.rs});
}

class GetTempState extends ScoreState {
  final int sum;
  final List<ScoreModel> data;

  GetTempState({required this.sum, required this.data});
}

class GetScoreEmpty extends ScoreState {}

class GetScoreFail extends ScoreState {}

class AddItemSuccess extends ScoreState {}

class DeleteItemSuccess extends ScoreState {}
