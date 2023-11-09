import 'package:firebase/modules/registeration/cubit/cubit.dart';
import 'package:firebase/modules/registeration/cubit/states.dart';
import 'package:firebase/modules/registeration/registeration.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/network/local/Cache_hilper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constants.dart';
import '../social_layout/social_layout.dart';


class LoginSocial  extends StatelessWidget {

  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<socialCubit,States>(
      listener: (context,state){

        if(state is succsess_login_state){
          CachHelper.savedata(
            key: 'uId',
            value: state.uId
          ).then((value) {
            NavigateAndRemove(context, SocialLayout());
          });
          //NavigateAndRemove(context, SocialLayout());

        }


      },
      builder: (context,state) {


        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0), // Optional padding
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.email,), labelText: 'email',),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.password,), labelText: 'password',),
                  ),
                  SizedBox(height: 30,),
                  FloatingActionButton(
                    onPressed: () {
                      socialCubit.get(context).login(emailcontroller.text.toString().trim(), passwordcontroller.text.toString().trim());
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20,),
                  TextButton(
                    onPressed: () {
                      NavigateTo(context, RegisterationSocial());
                    },
                    child: Text('Register now'),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
