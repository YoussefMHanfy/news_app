// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news/cubit/news_states.dart';
import 'package:news_app/modules/news_app/business/business_screen.dart';
import 'package:news_app/modules/news_app/science/science_screen.dart';
import 'package:news_app/modules/news_app/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() :super (NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem>bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center),
        label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),


  ];
  List<Widget> Screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  void ChangeBottomNavBar(int index)
  {
    currentIndex=index;
    emit(NewsBottomNavState());
  }
  List<dynamic> business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
       url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) =>
    {
    business = value.data['articles'],
        print(business[0]['title']),

    emit(NewsGetBusinessSuccessState()),
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
    });
    }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',

        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getData(
         url: 'v2/top-headlines',

        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }
  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
       url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    bool isShow,
    IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }

  bool isDark =false;
  void changeAppMode(
      {bool fromShared}
      )
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
