import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mob/page/home_page.dart';
import 'package:mob/page/score_bloc/score_bloc.dart';
import 'package:mob/page/user_score_bloc/user_score_bloc.dart';

import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ScoreBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UserScoreBloc>(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            cardTheme:
                const CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
          ),
          home: HomePage(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
