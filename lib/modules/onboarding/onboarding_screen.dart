import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../layout/news_app/news_layout.dart';
import '../../shared/network/local/cache_helper.dart';
class BoardingModel
{
  late final String image;

  late final String title;

  late final String body;

  BoardingModel({required this.image,required this.title,required this.body,});
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}
var boardController=PageController();
bool isDark=false;
class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel>onB=[
    BoardingModel(image:'assets/images/t1.jpg',title: 'Welcome to the news app ', body: 'All car news in the world',),
    BoardingModel(image:'assets/images/b1.jpg',title: 'Welcome to the news app',body: 'All businesses news in the world',),
    BoardingModel(image:'assets/images/s1.jpg',title: 'Welcome to the news app',body: 'All sports news in the world',),

  ];

  void navigateAndFinish(
      context,
      widget,
      ) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
            (Route<dynamic> route) => false,
      );

  Widget defaultTextButton({
    required Function function,
    required String text,
  }) =>
      TextButton(
        onPressed: () {
          function();
        },
        child: Text(text.toUpperCase()),
      );

  bool isLast=false;
  void submit()
  {
    CacheHelper.saveData(key: 'boarding', value: true).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, NewsLayout(),
        );
      }

    });

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(

              function: submit,
              text: 'Skip'),
        ],
      ),
      body: Padding(
        padding:const EdgeInsets.all(20),
        child:Column(
          children: [
            Expanded(child:  PageView.builder(
              onPageChanged: (int index)
              {
                if(index==onB.length-1)
                {
                  setState(() {
                    isLast=true;
                  });

                }
                else
                {
                  setState(() {
                    isLast=false;
                  });
                }
              },
              controller: boardController,
              itemBuilder: (context, index) => buildBoardingItem(onB[index]),
              itemCount: onB.length,physics: BouncingScrollPhysics(),
              reverse: false,
              scrollDirection: Axis.vertical,
            ),),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController, count: onB.length,
                  axisDirection: Axis.vertical,
                  effect:  ExpandingDotsEffect(
                    activeDotColor:isDark?Colors.amber:Colors.green ,
                    dotHeight: 12.0,
                    radius: 70.0,
                    dotColor: Colors.blueGrey,
                    expansionFactor: 5,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),),
                Spacer(),
                FloatingActionButton(onPressed: ()

                {
                  if(isLast)
                  {
                    submit();
                  }
                  else
                  {
                    boardController.nextPage(duration: Duration(milliseconds:
                    800,),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );

                  }

                },
                  child: Icon(Icons.arrow_downward_outlined,size: isLast?
                  50:30,color:isDark?Colors.amber:Colors.black ,
                    ),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children:  [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]);
}


