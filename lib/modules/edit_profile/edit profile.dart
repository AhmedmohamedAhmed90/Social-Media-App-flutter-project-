
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/appcubit/appcubit.dart';
import '../../shared/appcubit/appstates.dart';

class Edit_Profile extends StatelessWidget {


  var namecontroller=TextEditingController();
  var biocontroller=TextEditingController();
  var phonecontroller=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {

        },
        builder: (context,state) {
          var model=AppCubit.get(context).user;
          namecontroller.text=model.name.toString() ;
          biocontroller.text=model.bio.toString();
          phonecontroller.text=model.phone.toString();
          File profileimage=AppCubit.get(context).profileimage;
         File coverimage=AppCubit.get(context).coverimage;
         bool x;
         bool y;
         if(coverimage.path==''||coverimage.path==null){
           x=false;
         }
         else{
           x=true;
         }
          if(profileimage.path==''||profileimage.path==null){
            y=false;
          }
          else{
            y=true;
          }

          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 1, right: 2.5, left: 2.5),
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: x ==false  ?  NetworkImage('${model.cover}') : FileImage(coverimage)as ImageProvider,
                                        //FileImage(File(coverimage.path)),
                                        //coverimage ==null  ?  NetworkImage('${model.cover}') : FileImage(File(coverimage.path)),

                                        //FileImage(coverimage as File),

                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),)
                                  ),
                                ),
                              ),
                            ),

                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 65,
                                  child: CircleAvatar(
                                    backgroundImage:y ==false  ?  NetworkImage('${model.image}') : FileImage(profileimage)as ImageProvider,
                                    radius: 60,

                                  ),
                                ),
                                CircleAvatar(child: IconButton(onPressed: (){AppCubit.get(context).getProfileImage();}, icon: Icon(Icons.edit),color: Colors.blue,),
                                  backgroundColor: Colors.white,),
                              ],

                            ),
                          ],

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(child: IconButton(onPressed: (){AppCubit.get(context).getCoverImage();}, icon: Icon(Icons.edit),color: Colors.blue,),
                          backgroundColor: Colors.white,),
                      ),
                    ],

                  ),
                  if(AppCubit.get(context).profileimage!=null||AppCubit.get(context).coverimage!=null)
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(onPressed: () {AppCubit.get(context).uploadprofileimage(name: namecontroller.text, phone: phonecontroller.text, bio:biocontroller.text);},
                              color: Colors.blue,
                              child: Text('Upload Profile',
                                style: TextStyle(color: Colors.white),),),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(onPressed: () {AppCubit.get(context).uploadcoverimage(name: namecontroller.text, phone: phonecontroller.text, bio:biocontroller.text);},
                              color: Colors.blue,
                              child: Text('Upload Cover',
                                style: TextStyle(color: Colors.white),),),
                          ),
                        ),
                      ],
                    ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: namecontroller,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                    ),
                    ),
                  ),

                  SizedBox(height: 30,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: biocontroller,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),

                      ),
                    ),
                  ),

                  SizedBox(height: 30,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phonecontroller,
                      keyboardType: TextInputType.phone,

                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),

                      ),
                    ),
                  ),


                  SizedBox(height: 25,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(minWidth: double.infinity,onPressed: (){AppCubit.get(context).updateuser(name: namecontroller.text,phone: phonecontroller.text,bio: biocontroller.text);},
                      child:Text('Update',style: TextStyle(color:Colors.white ),),color: Colors.blue,),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}
