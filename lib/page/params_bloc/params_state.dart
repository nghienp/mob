part of 'params_bloc.dart';

@immutable
abstract class ParamsState {}

class ParamsInitial extends ParamsState {}

class ChangeWinnerSuccess extends ParamsState {
  final String winner;

  ChangeWinnerSuccess({required this.winner});
}
