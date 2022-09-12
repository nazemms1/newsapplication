

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';


class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
        LinearProgressIndicator();
        chooseToastColor(ToastStates.SUCCESS);
      },
      builder: (context, state)
      {
        chooseToastColor(ToastStates.SUCCESS);
        var list=NewsCubit.get(context).health;

        return BuilderArticle(list,context);
      } ,
    );
  }
}
