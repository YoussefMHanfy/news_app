// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news/cubit/news_states.dart';
import 'package:news_app/layout/news/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/components/constans.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/thems.dart';

import 'layout/news/cubit/news_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));

}

class MyApp extends StatelessWidget {
  final bool isDark;


  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => NewsCubit()
      ..getBusiness()
      ..getSports()
      ..getScience()
      ..changeAppMode(fromShared: isDark,),

      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
            home: NewsLayot(),
          );
        },
      ),
    );
  }
}


