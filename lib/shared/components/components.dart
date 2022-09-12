import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/web_view/web_screen.dart';

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

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

Widget buildArticaleItem(article, context, ) =>InkWell(
  onTap: ()
  {
    navigateTo(context,WebScreen(article['url']));
  },
child:Padding(
  padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10,left: 10),

        child:Column(
          children: [
            Container(
              width:400,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
        Container(
          child:   Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${article['title']}',
                style: Theme.of(context).textTheme.bodyText1,

                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20,),
              Container(
                height: 50.0,
                child:   Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text('${article['publishedAt']}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),),
                        SizedBox(width: 15,),
                        Expanded(child:    Text(
                          '${article['author']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),),
                      ],
                    )
                  ],
                ),
              ),
              // Expanded(
              //   child: Container(
              //     height: 120.0,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Expanded(
              //           child: Text(
              //             '${article['title']}',
              //             style: Theme.of(context).textTheme.bodyText1,
              //
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               '${article['publishedAt']}',
              //               style: const TextStyle(
              //                 color: Colors.grey,
              //               ),
              //             ),
              //             SizedBox(height: 5,),
              //             Text(
              //               '${article['author']}',
              //               style: const TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.grey,
              //               ),
              //               maxLines: 3,
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
  ],
        ),
),

    );

Widget BuilderArticle(list,context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) =>
              buildArticaleItem(list[index], context,  ),
          separatorBuilder: (context, index) => myDivider(),
          physics:  BouncingScrollPhysics(),
          itemCount: list.length),
      fallback: (context) => isSearch?Container(): Center(
        child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,
            strokeWidth:9,
      ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  bool isPassword = false,
  IconData? sufix,
  Function? onTap,
  ValueChanged<String>? onChange,
  required String label,
  FormFieldValidator<String>? validate,
  required IconData prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      // onTap: () {
      //   onTap!();
      // },
      decoration: InputDecoration(
        labelText: label,

   iconColor: Colors.black,
        border: OutlineInputBorder(),

        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: sufix != null
            ? Icon(
          sufix,
        )
            : null,
      ),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}