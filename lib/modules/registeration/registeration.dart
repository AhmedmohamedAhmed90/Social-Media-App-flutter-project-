import 'package:firebase/modules/registeration/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../shared/components/components.dart';
import '../social_layout/social_layout.dart';
import 'cubit/states.dart';

class RegisterationSocial  extends StatelessWidget {

  var usernamecontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var phonecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<socialCubit,States>(
      listener: (context,state){

      },
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text('Register',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: usernamecontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.verified_user,),
                      labelText: 'username',),

                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,), labelText: 'email',),

                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password,), labelText: 'password',),

                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone,), labelText: 'phone number',),

                  ),
                  SizedBox(height: 30,),
                  FloatingActionButton(onPressed: () {
                    socialCubit.get(context).registaerate(usernamecontroller.text,emailcontroller.text.toString().trim(),phonecontroller.text, passwordcontroller.text.toString().trim());
                  }, child: Text('Regi'),),

                  SizedBox(height: 20,),


                ],
              ),
            ),
          ),

        );

      }
    );
  }
}
