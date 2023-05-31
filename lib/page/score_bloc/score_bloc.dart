import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasource/firebase_datasource.dart';
import '../../model/score_model.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final FirebaseDataSource firebaseDataSource;

  ScoreBloc({required this.firebaseDataSource}) : super(ScoreInitial()) {
    // late List<ScoreModelResponse> listScore = [];

    on<GetScoreEvent>((event, emit) async {
      emit(GetScoreLoading());
      try {
        await firebaseDataSource.getAllData().then((rs) {
          if (rs.isNotEmpty) {
            // listScore = rs;
            emit(GetScoreSuccess(rs: rs));
          } else if (rs.isEmpty) {
            emit(GetScoreEmpty());
          }
        });
      } catch (e) {
        emit(GetScoreFail());
      }
    });
    on<AddItemEvent>((event, emit) async {
      try {
        await firebaseDataSource.addItem(event.data);
        emit(AddItemSuccess());
      } catch (e) {
        emit(GetScoreFail());
      }
    });
    on<DeleteItemEvent>((event, emit) async {
      try {
        await firebaseDataSource.deleteItem(event.data);
        emit(DeleteItemSuccess());
      } catch (e) {
        emit(GetScoreFail());
      }
    });
    on<TempData>((event, emit) async {
      try {
        emit(GetTempState(sum: event.sum, data: event.data));
      } catch (e) {
        emit(GetScoreFail());
      }
    });
  }
}
