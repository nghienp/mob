import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mob/page/score_bloc/score_bloc.dart';
import 'package:mob/page/score_editor_page.dart';
import 'package:mob/page/widget/app_button.dart';
import 'package:mob/page/widget/score_card.dart';

import '../model/score_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ScoreBloc>().add(GetScoreEvent());
    super.initState();
  }

  late List<ScoreModelResponse> listScore = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money over bitches'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ScoreBloc>().add(GetScoreEvent());
          },
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: BlocListener<ScoreBloc, ScoreState>(
                listener: (context, state) {
                  if (state is GetScoreSuccess) {
                    setState(() {
                      listScore = state.rs;
                    });
                  } else if (state is GetScoreLoading) {
                    // setState(() {
                    //   listScore = state.rs;
                    // });
                  } else if (state is AddItemSuccess) {
                    context.read<ScoreBloc>().add(GetScoreEvent());
                  } else if (state is DeleteItemSuccess) {
                    context.read<ScoreBloc>().add(GetScoreEvent());
                  } else {}
                },
                child: SizedBox(
                  height: context.screenSize.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listScore.length,
                        itemBuilder: (context, i) {
                          return ScoreCard(
                            title: listScore[i].title ?? '',
                            onDismissed: (direction) {
                              context.read<ScoreBloc>().add(DeleteItemEvent(data: listScore[i]));
                              setState(() {
                                listScore.remove(listScore[i]);
                              });
                            },
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScoreEditorPage(
                                        data: listScore[i],
                                        index: i,
                                      )));
                            },
                          );
                        },
                      ),
                      Center(
                        child: InkWell(
                          onTap: addItem,
                          child: const Icon(Icons.add_rounded),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  addItem() {
    String docId = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()).toString();
    context.read<ScoreBloc>().add(AddItemEvent(
            data: ScoreModelResponse(title: docId, data: const [
          ScoreModel(name: '', score: 0),
          ScoreModel(name: '', score: 0),
          ScoreModel(name: '', score: 0),
          ScoreModel(name: '', score: 0),
        ])));
  }
}

// addItemSheet() {
//   showModalBottomSheet(
//       context: context,
//       useRootNavigator: true,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       // barrierColor: barrierColor,
//       // isDismissible: isDismissible ?? false,
//       enableDrag: true,
//       builder: (context) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               height: 6,
//               width: 48,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.white,
//               ),
//               margin: const EdgeInsets.symmetric(vertical: 8),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.only(
//                 bottom: 16 * 2,
//                 top: 16,
//               ),
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.8,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Tên   ',
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: TextField(
//                             autofocus: true,
//                             controller: _nameController,
//                             enabled: true,
//                             onChanged: (v) => setState(() {}),
//                             // keyboardType: const TextInputType.,
//                             // inputFormatters: [
//                             //   FilteringTextInputFormatter.allow(RegExp("^-?\\d*")),
//                             //   LengthLimitingTextInputFormatter(4),
//                             // ],
//                             decoration: InputDecoration(
//                                 border: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                                 ),
//                                 suffixIcon: InkWell(
//                                     onTap: () {
//                                       _nameController.clear();
//                                     },
//                                     child: const Icon(Icons.close, size: 20))
//                                 // focusColor: AppColor.gray,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Điểm',
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: TextField(
//                             autofocus: true,
//                             controller: _scoreController,
//                             enabled: true,
//                             onChanged: (v) => setState(() {}),
//                             keyboardType: const TextInputType.numberWithOptions(signed: true),
//                             inputFormatters: [
//                               FilteringTextInputFormatter.allow(RegExp("^-?\\d*")),
//                               LengthLimitingTextInputFormatter(4),
//                             ],
//                             decoration: InputDecoration(
//                                 border: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                                 ),
//                                 suffixIcon: InkWell(
//                                     onTap: () {
//                                       _scoreController.clear();
//                                     },
//                                     child: const Icon(Icons.close, size: 20))
//                                 // focusColor: AppColor.gray,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     AppButton(
//                       text: 'Xác nhận',
//                       onPressed: _nameController.text != ''
//                           ? () {
//
//                             }
//                           : null,
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         );
//       });
// }
// builder: (context, state) {
// if (state is GetScoreSuccess || state is GetScoreLoading) {
// return Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// ListView.builder(
// physics: const ClampingScrollPhysics(),
// shrinkWrap: true,
// itemCount: state.rs.length,
// itemBuilder: (context, i) {
// return ScoreCard(
// title: state.rs[i].title ?? '',
// onDismissed: (direction) {
// context.read<ScoreBloc>().add(DeleteItemEvent(data: state.rs[i]));
// },
// onTap: () {
// Navigator.of(context).push(MaterialPageRoute(
// builder: (context) => ScoreEditorPage(
// index: i,
// )));
// },
// );
// },
// ),
// Center(
// child: InkWell(
// onTap: addItem,
// child: const Icon(Icons.add_rounded),
// ),
// )
// ],
// );
// } else if (state is GetScoreEmpty) {
// return ListView(
// shrinkWrap: true,
// children: [
// Center(
// child: InkWell(
// onTap: addItem,
// child: const Icon(Icons.add_rounded),
// ),
// )
// ],
// );
// } else if (state is GetScoreLoading) {
// return Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// ListView.builder(
// physics: const ClampingScrollPhysics(),
// shrinkWrap: true,
// itemCount: state.rs.length,
// itemBuilder: (context, i) {
// return ScoreCard(
// title: state.rs[i].title ?? '',
// onDismissed: (direction) {
// context.read<ScoreBloc>().add(DeleteItemEvent(data: state.rs[i]));
// },
// onTap: () {
// Navigator.of(context).push(MaterialPageRoute(
// builder: (context) => ScoreEditorPage(
// index: i,
// )));
// },
// );
// },
// ),
// Center(
// child: InkWell(
// onTap: addItem,
// child: const Icon(Icons.add_rounded),
// ),
// )
// ],
// );
// } else {
// return ListView(
// shrinkWrap: true,
// children: [
// SizedBox(
// height: 500,
// child: Center(
// child: Text(
// 'Lỗi cmm rồi',
// style: Theme.of(context).textTheme.titleLarge,
// ),
// ),
// )
// ],
// );
// }
// },
