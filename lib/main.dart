import 'package:firebase/modules/login_social/login_social.dart';
import 'package:firebase/modules/registeration/cubit/cubit.dart';
import 'package:firebase/modules/social_layout/social_layout.dart';
import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/components/constants.dart';
import 'package:firebase/shared/network/local/Cache_hilper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await CachHelper.init();
   Widget widget;
   uId=CachHelper.getData(key: 'uId');

 /* if(uId is String){
    widget=SocialLayout();
  }
  else{
    widget=LoginSocial();
  }*/

   if(uId != null){
     widget=SocialLayout();
   }
   else{
     widget=LoginSocial();
   }
   //widget=LoginSocial();

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final startwidget;
  MyApp(this.startwidget);
  //const MyApp(this.startwidget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => socialCubit()),
      BlocProvider(create: (context) => AppCubit()..getuser(uId)..getUsers()..getPosts()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:startwidget,
    )
    );
  }
}
