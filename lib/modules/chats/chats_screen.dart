import 'package:firebase/modules/chat_details/chat_details.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/appcubit/appstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Chats_Screen extends StatelessWidget {
  const Chats_Screen({super.key});



  @override
  Widget build(BuildContext context) {
  return BlocConsumer<AppCubit,AppStates>(
  listener: (context,state){

  },
  builder:(context,state) {

  if(state is Loading_getAllusers_state){
  return Center(child: CircularProgressIndicator());
  }
  var cubit= AppCubit.get(context);
  if(cubit.usersmodel.length>0)
  return SingleChildScrollView(
  child: ListView.separated(itemBuilder:(context,index)=> buildUserChat(context,index,cubit.usersmodel[index]),
  itemCount: cubit.usersmodel.length,
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  separatorBuilder:(context,index)=> Container(height: 2,color: Colors.grey[350],),

  ),
  );
  else{
  return Container();
  }
  }


  );
  }

  Widget buildUserChat(context,index,UserModel model){
  return Padding(
  padding: const EdgeInsets.all(20.0),
  child: InkWell(
  onTap: (){NavigateTo(context, Chat_details(model));},
  child: Row(
  children: [
  Row(
  children: [
  SizedBox(width: 5,),

  CircleAvatar(backgroundImage: NetworkImage('${model.image}'),

  ),
  SizedBox(width: 5,),
  Text('${model.name}', style: TextStyle(
  fontWeight: FontWeight.bold, fontSize: 16),),
  SizedBox(width: 5,),
  Icon(Icons.check_circle, color: Colors.blue,
  size: 17,),

  ],
  ),
  ]
  ),
  ),
  );
  }
  }
