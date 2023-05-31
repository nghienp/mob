import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'params_event.dart';
part 'params_state.dart';

class ParamsBloc extends Bloc<ParamsEvent, ParamsState> {
  final List<String> avoid = [
    '',
    'nghiệp',
    'Nghiệp',
    'nghịp',
    'Nghịp',
    'nghiep',
    'Nghiep',
    'nghip',
    'Nghip',
    'NGHIỆP',
    'NGHIEP',
    'NGHỊP',
    'NGHIP'
  ];

  ParamsBloc() : super(ParamsInitial()) {
    on<ChangeWinnerEvent>((event, emit) {
      if (!avoid.contains(event.winner)) {
        emit(ChangeWinnerSuccess(winner: event.winner));
      }
    });
  }
}
