
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark=false;
  ThemeMode appMode=ThemeMode.dark;

  void changeAppMode({ bool ?fromShared}) {
if(fromShared!=null)
{
  isDark=fromShared;
emit(AppChangeModeState());
}
  else
{
  isDark = !isDark;
  CacheHelper.putData(key: 'isDark', value: isDark).then((value) {emit(AppChangeModeState());});

}

      }
    }
