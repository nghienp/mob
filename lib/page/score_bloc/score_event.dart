part of 'score_bloc.dart';

@immutable
abstract class ScoreEvent {}

class GetScoreEvent extends ScoreEvent {}

class AddItemEvent extends ScoreEvent {
  final ScoreModelResponse data;

  AddItemEvent({required this.data});
}

class DeleteItemEvent extends ScoreEvent {
  final ScoreModelResponse data;

  DeleteItemEvent({required this.data});
}
