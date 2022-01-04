// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news/cubit/news_cubit.dart';
import 'package:news_app/layout/news/cubit/news_states.dart';
import 'package:news_app/modules/news_app/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
class NewsLayot extends StatelessWidget {
  const NewsLayot({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>
        ( listener: (context ,state){},
        builder: (context,stats){
          var cubit =NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen(),);
                  },
                  icon:Icon (Icons.search),
              ),
                IconButton(
                  onPressed: ()
                {
                  NewsCubit.get(context).changeAppMode();
                },
                  icon:Icon (Icons.brightness_4_rounded),
                )
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.ChangeBottomNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items:cubit.bottomItems,
            ),
          );
        },

      );
  }
}

