import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob/page/score_bloc/score_bloc.dart';
import 'package:mob/page/user_score_bloc/user_score_bloc.dart';
import 'package:mob/page/widget/app_button.dart';
import 'package:mob/page/widget/user_score_widget.dart';
import 'package:stack/stack.dart' as stack;

import '../model/score_model.dart';

class ScoreEditorPage extends StatefulWidget {
  const ScoreEditorPage({super.key, required this.data, required this.index});

  final ScoreModelResponse data;
  final int index;

  @override
  State<ScoreEditorPage> createState() => _ScoreEditorPageState();
}

class _ScoreEditorPageState extends State<ScoreEditorPage> {
  List<ScoreModel> listScore = [];
  late int sum = 0;
  late ScoreModelResponse data = const ScoreModelResponse(title: '', data: []);
  late stack.Stack<ScoreModelResponse> backupData = stack.Stack();
  late String winner = '';
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

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ScoreBloc>().add(GetScoreEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(data.title),
          actions: const [
            InkWell(
              child: Icon(Icons.settings_backup_restore),
            ),
            SizedBox(width: 16)
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<UserScoreBloc, UserScoreState>(
                listener: (context, state) {
                  if (state is UserScoreSuccess) {
                    context.read<ScoreBloc>().add(GetScoreEvent());
                  }
                },
                child: BlocListener<ScoreBloc, ScoreState>(
                  listener: (context, state) {
                    if (state is GetScoreSuccess) {
                      data = state.rs[widget.index];
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemCount: data.data.length,
                          itemBuilder: (context, i) {
                            return Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  tempEdit();
                                  // setState(() {});
                                }
                              },
                              child: UserScoreWidget(
                                data: data.data[i],
                                onChange: (scoreModel) {
                                  data.data[i] = scoreModel;
                                },
                                onSubmitted: (scoreModel) {
                                  editUserScore();
                                },
                                index1: widget.index,
                                index2: i,
                              ),
                            );
                          }),
                      const SizedBox(height: 20),
                      BlocBuilder<ScoreBloc, ScoreState>(
                        builder: (context, state) {
                          if (state is GetTempState) {
                            return Text(
                              'Tổng: ${state.sum == 0 ? state.sum : '${state.sum} Sai rồi thằng lz'}',
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          } else {
                            return Text(
                              'Tổng: ${sum == 0 ? sum : '$sum Sai rồi thằng lz'}',
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 50),
                      !avoid.contains(winner)
                          ? SizedBox(
                              width: context.screenSize.width,
                              child: Text(
                                '${winner.toUpperCase()} mày điiiii',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(),
                      const Spacer(),
                      AppButton(
                        text: 'OK',
                        onPressed: () {
                          editUserScore();
                        },
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  editUserScore() {
    sum = 0;
    ScoreModel min = data.data.first;

    for (var element in data.data) {
      sum += element.score;
      if (element.score < min.score) min = element;
      winner = min.name;
    }

    context.read<ScoreBloc>().add(AddItemEvent(data: data));
    setState(() {});
  }

  tempEdit() {
    sum = 0;
    for (var element in data.data) {
      sum += element.score;
    }
    context.read<ScoreBloc>().add(TempData(data: data.data, sum: sum));
  }
}

// class ListScoreWidget extends StatelessWidget {
//   final ScoreModelResponse data;
//
//   const ListScoreWidget({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//         itemCount: data.data.length,
//         itemBuilder: (context, i) {
//           return UserScoreWidget(
//             onNameChanged: (name) {},
//             onScoreChanged: (score) {},
//             data: data.data[i],
//           );
//         });
//   }
// }
