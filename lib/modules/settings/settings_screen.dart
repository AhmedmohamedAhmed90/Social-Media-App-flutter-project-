
import 'package:firebase/modules/edit_profile/edit%20profile.dart';
import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/appcubit/appstates.dart';

class Settings_Screen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {


    },
    builder: (context,state) {
      var model=AppCubit.get(context).user;
      return Column(
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
                          image: DecorationImage(image: NetworkImage(
                              '${model.cover}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),)
                      ),
                    ),
                  ),
                ),

                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 65,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${model.image}'),
                    radius: 60,

                  ),
                ),
              ],

            ),
          ),

          Text('${model.name}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
          Text('${model.bio}', style: TextStyle(fontSize: 15),),
          SizedBox(height: 30,),
          Row(

            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(child: Text(
                        'posts', style: TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {},),
                    Text('100'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(child: Text(
                        'photos', style: TextStyle(fontWeight: FontWeight
                        .bold)), onTap: () {},),
                    Text('100'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(child: Text(
                        'folowers', style: TextStyle(fontWeight: FontWeight
                        .bold)), onTap: () {},),
                    Text('10K'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(child: Text(
                        'folowing', style: TextStyle(fontWeight: FontWeight
                        .bold)), onTap: () {},),
                    Text('300'),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(minWidth: double.infinity,onPressed: (){NavigateTo(context,Edit_Profile());},child:Text('Edit Profile',style: TextStyle(color:Colors.white ),),color: Colors.blue,),
          ),
        ],
      );
    }
    );
  }
}