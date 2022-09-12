import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapplication/shared/bloc_observer.dart';
import 'package:newsapplication/shared/cubit/cubit.dart';
import 'package:newsapplication/shared/cubit/states.dart';
import 'package:newsapplication/shared/network/local/cache_helper.dart';
import 'package:newsapplication/shared/network/remote/dio_helper.dart';



import 'layout/news_app/cubit/cubit.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool ?isDark=CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark:isDark));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  MyApp({
    required this.isDark,
  });
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[BlocProvider(create: (context)=>
    NewsCubit()
      ..getBusiness()
      ..getCars()
      ..getSports()..getHealth(),
    ),
      BlocProvider(create:(context)=> AppCubit()
        ..changeAppMode(fromShared: isDark),),
    ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                actionsIconTheme: IconThemeData(size: 25),
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),

                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.green,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.lightGreen,

                showUnselectedLabels: false,
                backgroundColor: Colors.white70,
                unselectedItemColor: Colors.grey,
                elevation: 10.0,
                selectedLabelStyle:   TextStyle(
                  fontSize: 10,
                  letterSpacing: 2.0,

                ),

              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.amber,
              scaffoldBackgroundColor:HexColor('242422'),
              appBarTheme:   AppBarTheme(
                titleSpacing: 20.0,

                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('242422'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('242422'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.amberAccent,
              ),
              bottomNavigationBarTheme:   BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,

                selectedItemColor: Colors.amberAccent,
                unselectedItemColor: Colors.grey[1],
                elevation: 10.0,
                backgroundColor: HexColor('242422'),
                selectedLabelStyle: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 2.0,

                ),

              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home:  OnBoarding(),
          );
        },
      ),
    );
  }
}

