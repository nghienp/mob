part of 'params_bloc.dart';

@immutable
abstract class ParamsEvent {}

class ChangeWinnerEvent extends ParamsEvent {
  final String winner;

  ChangeWinnerEvent({required this.winner});
}
