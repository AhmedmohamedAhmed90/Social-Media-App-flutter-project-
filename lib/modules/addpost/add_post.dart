

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/appcubit/appcubit.dart';
import '../../shared/appcubit/appstates.dart';

class Add_Post extends StatelessWidget {

  var postcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {


        },
        builder: (context,state){
          if(state is succsess_getposts_state){
            postcontroller.text='';
            AppCubit.get(context).removePostimage();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
              state is Loading_Createpost_state || state is Loading_Upoladpostimage_state
                  ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: LinearProgressIndicator(),
                  )
                  : Container(),

            Row(
            children: [
            Expanded(
            child: Row(
            children: [
            SizedBox(width: 5,),

            CircleAvatar(backgroundImage: NetworkImage('${AppCubit.get(context).user.image}'),

            ),
            SizedBox(width: 5,),
            Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
            Row(
            children: [
            Text('${AppCubit.get(context).user.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(width:5 ,),
            Icon(Icons.check_circle,color: Colors.blue,size: 17,),
            ],
            ),
            Row(
              children: [
                Text('${DateTime.now().year}-',style: TextStyle(fontSize: 14),),
                Text('${DateTime.now().month}-',style: TextStyle(fontSize: 14),),
                Text('${DateTime.now().day}',style: TextStyle(fontSize: 14),),
              ],
            )
            ],
            ),

              ]
            ),
            ),
            ]
            ),
              Expanded(
                child: TextFormField(
                  onTap: (){},
                  controller:postcontroller ,
decoration: InputDecoration(hintText: 'Add text here',border: InputBorder.none),


                ),
              ),
              //AppCubit.get(context).postimage!=null||AppCubit.get(context).postimage!=''||AppCubit.get(context).postimage.path!=''
             if(state is succsess_Pickpostimage_state)
             Stack(
                alignment: AlignmentDirectional.topEnd,
                 children: [
                   Container(
                     width: double.infinity,
                     height: 150,
                     decoration: BoxDecoration(

                     ),
                     child: Card(
                       child: Image(image: FileImage(AppCubit.get(context).postimage),
                         fit: BoxFit.cover,
                         height: 150,
                       ),

                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(child: CircleAvatar(child: Text('X'),backgroundColor: Colors.blue,),onTap:(){AppCubit.get(context).removePostimage();} ,),
                   ),
                 ],
              )
              else
             Container(),

              Row(
                children: [
                  Expanded(child: MaterialButton(onPressed: (){
                    AppCubit.get(context).getPostImage();
                  },color: Colors.blue,child: Text('Add Photo',style: TextStyle(color: Colors.white),),)),
                  SizedBox(width:7 ,),
                  Expanded(child: MaterialButton(onPressed: (){

                    var now=DateTime.now();
                    if(AppCubit.get(context).postimage==null||AppCubit.get(context).postimage==''||AppCubit.get(context).postimage.path==''){
                      AppCubit.get(context).createPost(dateTime: now.toString(), text: postcontroller.text);

                    }
                    else{
                      AppCubit.get(context).uploadpostimage(dateTime: now.toString(), text: postcontroller.text);

                    }


                  },color: Colors.blue,child: Text('Post',style: TextStyle(color: Colors.white),),)),
                ],
              )

            ]
            ),
          );





        }
    );
  }
}
