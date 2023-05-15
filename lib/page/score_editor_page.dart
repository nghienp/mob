import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mob/page/score_bloc/score_bloc.dart';
import 'package:mob/page/widget/user_score_widget.dart';

class ScoreEditorPage extends StatefulWidget {
  const ScoreEditorPage({super.key, required this.title});

  final String title;

  @override
  State<ScoreEditorPage> createState() => _ScoreEditorPageState();
}

class _ScoreEditorPageState extends State<ScoreEditorPage> {
  @override
  void initState() {
    context.read<ScoreBloc>().add(GetScoreEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocConsumer<ScoreBloc, ScoreState>(
              listener: (context, state) {
                if (state is GetScoreLoading) {
                  EasyLoading.show();
                } else {
                  EasyLoading.dismiss();
                }
              },
              builder: (context, state) {
                if (state is GetScoreSuccess) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: state.rs.length,
                      itemBuilder: (context, i) {
                        return UserScoreWidget(
                          name: state.rs.first.data[i].name,
                          score: state.rs.first.data[i].score,
                        );
                      });
                  // children: [UserScoreWidget()],/
                } else if (state is GetScoreLoading) {
                  return const SizedBox();
                }
                return SizedBox(
                    height: 500,
                    child: Center(
                      child: Text('LỖI MẸ RỒI', style: Theme.of(context).textTheme.titleLarge),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
