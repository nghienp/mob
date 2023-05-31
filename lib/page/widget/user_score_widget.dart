import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/score_model.dart';
import '../score_bloc/score_bloc.dart';

class UserScoreWidget extends StatefulWidget {
  UserScoreWidget(
      {Key? key,
      required this.data,
      required this.onChange,
      required this.onSubmitted,
      required this.index1,
      required this.index2})
      : super(key: key);
  final ScoreModel data;

  final void Function(ScoreModel value) onChange;
  final void Function(ScoreModel value) onSubmitted;

  final int index1;
  final int index2;

  // final void Function(String value) onChangedName;
  // final void Function(int value) onChangeScore;

  @override
  State<UserScoreWidget> createState() => _UserScoreWidgetState();
}

class _UserScoreWidgetState extends State<UserScoreWidget> {
  late TextEditingController _textController = TextEditingController();
  late TextEditingController _scoreController = TextEditingController();

  late int _currentScore;

  late String _currentName;
  late int _previousScore;
  ScoreModel rs = const ScoreModel(name: '', score: 0);

  @override
  void initState() {
    _currentScore = widget.data.score;
    _currentName = widget.data.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {},
      key: UniqueKey(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.data.name != ''
                  ? Expanded(flex: 2, child: Text(widget.data.name, style: Theme.of(context).textTheme.titleLarge))
                  : SizedBox(
                      height: 50,
                      width: 150,
                      child: TextField(
                        controller: _textController,
                        enabled: true,
                        onChanged: (v) {
                          _currentName = v;
                          rs = ScoreModel(name: _currentName, score: _currentScore);
                          widget.onChange(rs);
                        },
                        onSubmitted: (v) => setState(() {
                          rs = ScoreModel(name: _currentName, score: _currentScore);
                          widget.onSubmitted(rs);
                        }),
                        decoration: InputDecoration(
                          hintText: 'Nhập tên...',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          // suffixIcon: InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         _textController.clear();
                          //         _currentName = '';
                          //       });
                          //     },
                          //     child: const Icon(Icons.close, size: 20))
                          // focusColor: AppColor.gray,
                        ),
                      ),
                    ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: BlocBuilder<ScoreBloc, ScoreState>(
                  builder: (context, state) {
                    if (state is GetScoreSuccess) {
                      return Text(state.rs[widget.index1].data[widget.index2].score.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.red));
                    } else if (state is GetTempState) {
                      return Text(state.data[widget.index2].score.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.red));
                    } else {
                      return Text(widget.data.score.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.red));
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: TextField(
                    controller: _scoreController,
                    enabled: true,
                    onChanged: (v) {
                      _currentScore = widget.data.score + (int.tryParse(v != '' ? v : '0') ?? 0);
                      rs = ScoreModel(name: _currentName, score: _currentScore);
                      widget.onChange(rs);
                    },
                    onSubmitted: (v) => setState(() {
                      _currentScore = widget.data.score + (int.tryParse(v != '' ? v : '0') ?? 0);
                      rs = ScoreModel(name: _currentName, score: _currentScore);
                      widget.onSubmitted(rs);
                      // _currentScore = 0;
                      // _scoreController.text = '';
                    }),
                    // onEditingComplete: () {
                    //   _currentScore = widget.data.score +
                    //       (int.tryParse(_scoreController.text != '' ? _scoreController.text : '0') ?? 0);
                    //   rs = ScoreModel(name: _currentName, score: _currentScore);
                    //   widget.onSubmitted(rs);
                    // },
                    // onTapOutside: (event) {
                    //   setState(() {
                    //     _currentScore += int.tryParse(_scoreController.text != '' ? _scoreController.text : '0') ?? 0;
                    //     _scoreController.text = '';
                    //     rs = ScoreModel(name: _textController.text, score: _currentScore);
                    //     widget.onSubmit(rs);
                    //   });
                    // },
                    keyboardType: const TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("^-?\\d*")),
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Nhập đỉm...',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      // suffixIcon: InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         _scoreController.clear();
                      //         _currentScore = 0;
                      //       });
                      //     },
                      //     child: const Icon(Icons.close, size: 20))
                      // focusColor: AppColor.gray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
