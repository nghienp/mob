import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasource/firebase_datasource.dart';
import '../../model/score_model.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final FirebaseDataSource firebaseDataSource;

  ScoreBloc({required this.firebaseDataSource}) : super(ScoreInitial()) {
    on<ScoreEvent>((event, emit) async {
      emit(GetScoreLoading());
      await firebaseDataSource.getAllData().then((rs) {
        if (rs.isNotEmpty) {
          emit(GetScoreSuccess(rs: rs));
        } else if (rs.isEmpty) {
          emit(GetScoreEmpty());
        }
      });
    });
  }
}
