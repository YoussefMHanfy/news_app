// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news/cubit/news_cubit.dart';
import 'package:news_app/layout/news/cubit/news_states.dart';
import 'package:news_app/shared/components/components.dart';
class BusinessScreen extends StatelessWidget {
  const BusinessScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewsCubit.get(context).business;

         return articleBuilder(list,context) ;
      },
    );
  }
  }

