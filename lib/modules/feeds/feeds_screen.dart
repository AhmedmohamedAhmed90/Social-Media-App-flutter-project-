import 'package:firebase/models/post_model.dart';
import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/appcubit/appstates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Feeds_Screen extends StatelessWidget {

  var commentcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){


      },
      builder: (context,state){
        if(state is Loading_getposts_state){
          return Center(child: CircularProgressIndicator());
        }
        var cubit=AppCubit.get(context);

       /* if(state is Loading_getposts_state){
          return Center(child: CircularProgressIndicator());
          ||AppCubit.get(context).posts.length==0
        }*/
        //if(cubit.posts.length>0)
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(

                    ),
                    child: Card(
                      child: Image(image: NetworkImage('https://img.freepik.com/free-vector/school-building-educational-institution-college_107791-1051.jpg?w=1380&t=st=1691001754~exp=1691002354~hmac=4c80a45957984ae4786c8d7151dabcbb5c0b42e5811c05a90bdc2caeba017bbc'),
                        fit: BoxFit.cover,
                        height: 150,
                      ),

                    ),
                  ),
                ),
              ),

              ListView.separated(itemBuilder:(context,index)=> BuildPost(cubit.posts[index],context,index),
                itemCount: cubit.posts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder:(context,index)=> SizedBox(height: 7,),

              ),
              SizedBox(height: 8,),

            ],
          ),
        );

      },


    );
  }

  Widget BuildPost(PostModel model,context,index)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child:Material(
      elevation: 6,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 5,),

                    CircleAvatar(backgroundImage: NetworkImage('${model.image}'),

                    ),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Row(
                          children: [
                            Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(width:5 ,),
                            Icon(Icons.check_circle,color: Colors.blue,size: 17,),
                          ],
                        ),
                        Text('${model.dateTime}',style: TextStyle(fontSize: 11),)
                      ],
                    ),

                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text('${model.text}'
              ,
              style: TextStyle(fontSize: 15),
            ),
          ),
          if(model.postImage!='')
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: double.infinity,
                child: Image(image: NetworkImage('${model.postImage}')),
              ),
            )
          else
            Container(),

//https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg?w=1380&t=st=1691009936~exp=1691010536~hmac=6f9db89f814314b62a7b3761200d36aea7471644970f6b15f85c3f9990d886c5
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(child: Icon(Icons.heart_broken_sharp,color: Colors.red,),onTap: (){AppCubit.get(context).likePost(AppCubit.get(context).postsid[index].toString());},),
                      SizedBox(width: 3,),
                      Text('${AppCubit.get(context).likes[index]}',)
                    ],
                  ),

                ),
                Row(
                  children: [
                    InkWell(child: Icon(Icons.comment,color: Colors.grey[700],),onTap: (){},),
                    SizedBox(width: 3,),
                    Text('${AppCubit.get(context).comments[index]}',)
                    //'${AppCubit.get(context).comments[index]}'
                  ],
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8,left: 8,top: 8),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3,left: 3,),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage('${AppCubit.get(context).user.image}'),
                        radius: 15,
                      ),
                      SizedBox(width: 5,),
                      Expanded(child: TextFormField(decoration: InputDecoration(hintText: 'Add Comment',border: InputBorder.none),controller:commentcontroller ,)),
                    ],

                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: (){AppCubit.get(context).CommentPost(AppCubit.get(context).postsid[index].toString(), commentcontroller.text);commentcontroller.text='';}, icon: Icon(Icons.comment,color: Colors.yellow,)),
                    Container(width: 2,height: 35,color: Colors.grey[300],),
                    IconButton(onPressed: (){AppCubit.get(context).likePost(AppCubit.get(context).postsid[index]);}, icon: Icon(Icons.heart_broken_sharp,color: Colors.red,)),
                    Text('Like',style: TextStyle(color: Colors.red),),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    ),
  );
}