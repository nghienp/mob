part of 'user_score_bloc.dart';

@immutable
abstract class UserScoreState {}

class UserScoreInitial extends UserScoreState {}

class UserScoreLoading extends UserScoreState {}

class UserScoreSuccess extends UserScoreState {}

class UserScoreFail extends UserScoreState {}
