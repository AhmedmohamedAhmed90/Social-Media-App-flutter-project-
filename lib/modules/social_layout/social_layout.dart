

import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/appcubit/appstates.dart';
import 'package:firebase/shared/components/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
   SocialLayout({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {

        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
     return Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentindex]),
          actions: [
            IconButton(onPressed: (){signout(context);}, icon: Icon(Icons.output)),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search))
          ],
        ),
        body: cubit.screens[cubit.currentindex],
        /*Column(
          children: [
            Text('Lay Out'),

            MaterialButton(onPressed: (){
              signout(context);
            },child: Text('sign out'),)


          ],
        ),*/
       bottomNavigationBar: BottomNavigationBar(items:[

           BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.grey,),label: 'Home',),
         BottomNavigationBarItem(icon: Icon(Icons.chat,color: Colors.grey,),label: 'Chats'),
         BottomNavigationBarItem(icon: Icon(Icons.verified_user_sharp,color: Colors.grey,),label: 'Users'),
         BottomNavigationBarItem(icon: Icon(Icons.post_add,color: Colors.grey,),label: 'Posts'),
         BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.grey,),label: 'Settings'),


          ],

           onTap: (index){
         cubit.changenav(index);
              },
         currentIndex: cubit.currentindex,

       ),
      );
    }
    );
  }
}
