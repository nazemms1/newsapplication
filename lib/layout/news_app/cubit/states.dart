abstract class NewsStates{}

class  NewInitialState extends NewsStates{}
class  NewsBottomNavState extends NewsStates{}
//States Business
class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates
{
 late final String error;
 NewsGetBusinessErrorState(this.error);
}

//States Sports
class NewsGetSportLoadingState extends NewsStates{}
class NewsGetSportSuccessState extends NewsStates{}
class NewsGetSportErrorState extends NewsStates {
 late final String error;

 NewsGetSportErrorState(this.error);
}
//States Sciences
 class NewsGetCarsLoadingState extends NewsStates{}
 class NewsGetCarsSuccessState extends NewsStates{}
 class NewsGetCarsErrorState extends NewsStates
 {
 late final String error;
 NewsGetCarsErrorState(this.error);
 }

class NewsGetHealthLoadingState extends NewsStates{}
class NewsGetHealthSuccessState extends NewsStates{}
class NewsGetHealthErrorState extends NewsStates
{
 late final String error;
 NewsGetHealthErrorState(this.error);
}

//Search
class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates
{
 late final String error;
 NewsGetSearchErrorState(this.error);
}