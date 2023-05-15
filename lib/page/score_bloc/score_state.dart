part of 'score_bloc.dart';

@immutable
abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class GetScoreLoading extends ScoreState {}

class GetScoreSuccess extends ScoreState {
  final List<ScoreModelResponse> rs;

  GetScoreSuccess({required this.rs});
}

class GetScoreEmpty extends ScoreState {}

class GetScoreFail extends ScoreState {}
