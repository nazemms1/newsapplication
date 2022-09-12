import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/layout/news_app/cubit/states.dart';

import '../../../modules/business/business_screen.dart';
import '../../../modules/cars/sciences_screen.dart';
import '../../../modules/health/health_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItem=[

    BottomNavigationBarItem(icon: Icon(Icons.directions_car_sharp),label: 'Cars', ),
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business',),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports',),
    BottomNavigationBarItem(icon: Icon(Icons.health_and_safety_rounded),
      label: 'Health',),
];


  List<Widget>screens=
  [ CarsScreen(),
    BusinessScreen(),
    SportsScreen(),
    HealthScreen(),
  ];

  List< dynamic  >business=[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'ae',
          'category':'business',
          'apiKey':'919b8b3003cc4bf5b3013ac1e563671b',

        },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business=value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());});
  }


  List<dynamic>sports=[];

  void getSports()
  {
    emit(NewsGetSportLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'us',
          'category':'sports',
          'apiKey':'919b8b3003cc4bf5b3013ac1e563671b',

        },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportSuccessState());
    }).catchError((error){
      emit(NewsGetSportErrorState(error.toString()));
      print(error.toString());});
  }

  List< dynamic  >cars=[];

  void getCars()
  {
    emit(NewsGetCarsLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query:
        {


          'q':'tesla',
          'from':'2022-07-0',
          'sortBy':'publishedAt',
          'apiKey':'919b8b3003cc4bf5b3013ac1e563671b',

        },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      cars=value.data['articles'];
      print(cars[0]['title']);
      emit(NewsGetCarsSuccessState() );
    }).catchError((error){
      emit(NewsGetCarsErrorState(error.toString()));
      print(error.toString());});
  }


  List< dynamic  >health=[];

  void getHealth()
  {
    emit(NewsGetHealthLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'ae',
        'category':'health',
        'apiKey':'919b8b3003cc4bf5b3013ac1e563671b',

      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      health=value.data['articles'];
      print(health[0]['title']);
      emit(NewsGetHealthSuccessState() );
    }).catchError((error){
      emit(NewsGetHealthErrorState(error.toString()));
      print(error.toString());});
  }


  List<dynamic >search=[];

  void getsearch(String value)
  {

    emit(NewsGetSearchLoadingState());
    search=[];
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':'$value',
          'apiKey':'919b8b3003cc4bf5b3013ac1e563671b',
        },
    ).then((value) {
     // print(value.data['articles'][0]['title']);
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState() );
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());});
  }

  void changeBottomNavBar(int index)
{
  currentIndex=index;
  emit(NewsBottomNavState());
}
}