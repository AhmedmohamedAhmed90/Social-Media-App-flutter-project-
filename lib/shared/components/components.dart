import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget newsbuilder (article){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //+66image: DecorationImage(image: NetworkImage('${article['urlToImage']}'),fit: BoxFit.cover),

          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text('${article['title']}',style: TextStyle(fontSize: 18,),maxLines: 3,overflow:TextOverflow.ellipsis ,)),
                Text('${article['publishedAt']}',style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
        )

      ],
    ),
  );



}


void NavigateTo(context,Widget)=>
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Widget)
    );


void NavigateAndRemove(context,Widget)=>

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Widget),

          (Route<dynamic> route)=>false,

    );