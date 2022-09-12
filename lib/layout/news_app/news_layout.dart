import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/search/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);

            return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('News ',textAlign: TextAlign.end,),
                actions: [
                  IconButton(
                    onPressed: ()
                    {
                      navigateTo(context, SearchScreen(),);
                    },
                    icon: Icon(
                      Icons.search_sharp,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeAppMode();},
                    icon: Icon(
                      Icons.brightness_6,
                    ),
                  ),
                  IconButton(onPressed: ()
                  {
                    navigateAndFinish(context, OnBoarding());
                  },
                      icon: Icon(Icons.arrow_forward),),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: cubit.bottomItem,
              ),
            );
          },
         );
  }
}
