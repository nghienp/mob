part of 'user_score_bloc.dart';

@immutable
abstract class UserScoreEvent {}

class EditUserScoreEvent extends UserScoreEvent {
  final ScoreModelResponse userScore;

  EditUserScoreEvent({required this.userScore});
}
