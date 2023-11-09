import 'package:firebase/models/message_model.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/appcubit/appstates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat_details extends StatelessWidget {


  UserModel model;
  Chat_details(this.model);
  var TextController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        AppCubit.get(context).getMessages('${model.uId}');


     return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [

                  CircleAvatar(backgroundImage: NetworkImage('${model.image}'),

                  ),
                  SizedBox(width: 5,),
                  Text('${model.name}', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(width: 5,),
                  Icon(Icons.check_circle, color: Colors.white,
                    size: 17,),

                ],
              ),
            ),
            body: Column(
              children: [
               /*BuildMessage(model),

                BuildMyMessage(model),*/
                if(AppCubit.get(context).messages.length>0)

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(itemBuilder: (context, index) {
                        var message = AppCubit
                            .get(context)
                            .messages[index];

                        if (AppCubit
                            .get(context)
                            .user
                            .uId == message.senderId)
                          return BuildMyMessage(message);
                        else {
                          return BuildMessage(message);
                        }
                      }
                        , separatorBuilder: (context, index) {
                          return SizedBox(height: 5,);
                        }

                        , itemCount: AppCubit.get(context).messages.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              )



                else
                 Expanded(child: Container()),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Add Message here',
                              border: InputBorder.none),controller:TextController ,)),
                        Container(
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                bottomRight: Radius.circular(14),),
                              color: Colors.lightBlue,
                            ),
                            child: IconButton(onPressed: () {AppCubit.get(context).SendMessage(model.uId, DateTime.now().toString(),TextController.text ); TextController.text='';},
                              icon: Icon(Icons.send),
                              color: Colors.white,))

                      ],
                    ),
                  ),
                ),

              ],
            ),

          );
        },
      );
      },
    );
  }

  Widget BuildMessage(MessageModel model){
    return  Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 8),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10), topStart: Radius
                .circular(10), bottomEnd: Radius.circular(10),),
            color: Colors.grey[300],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('${model.text}', style: TextStyle(
              fontSize: 20,),),
          ),
        ),
      ),
    );
  }

  Widget BuildMyMessage(MessageModel model){
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 8),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10), topStart: Radius
                .circular(10), bottomStart: Radius.circular(10),),
            color: Colors.blue[100],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('${model.text}', style: TextStyle(
              fontSize: 20,),),
          ),
        ),
      ),
    );
  }
}
