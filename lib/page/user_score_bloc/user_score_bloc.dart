import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasource/firebase_datasource.dart';
import '../../model/score_model.dart';

part 'user_score_event.dart';
part 'user_score_state.dart';

class UserScoreBloc extends Bloc<UserScoreEvent, UserScoreState> {
  final FirebaseDataSource firebaseDataSource;

  UserScoreBloc({required this.firebaseDataSource}) : super(UserScoreInitial()) {
    on<EditUserScoreEvent>((event, emit) {
      emit(UserScoreLoading());
      try {
        firebaseDataSource.editUserScore(event.userScore);
        emit(UserScoreSuccess());
      } catch (e) {
        emit(UserScoreFail());
      }
    });
  }
}
