
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase/modules/registeration/cubit/states.dart';
import 'package:firebase/shared/appcubit/appcubit.dart';
import 'package:firebase/shared/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/Cache_hilper.dart';
class socialCubit extends Cubit<States> {


  socialCubit() : super(initialstate());

  static socialCubit get(context) => BlocProvider.of(context);

  //UserModel model=UserModel( '',  '',  '',  '','','','');

  void registaerate(String name,String email,String phone,String password,){

    emit(Loading_Register_state());
    print('dadadada');

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      print('hahahaha');
      print(value.user?.email);
      print(value.user?.uid);
      createuser(name, email, phone, value.user?.uid,'https://img.freepik.com/free-photo/portrait-successful-man-having-stubble-posing-with-broad-smile-keeping-arms-folded_171337-1267.jpg?w=1060&t=st=1691171023~exp=1691171623~hmac=368973de2fbd861a0efec9d0a10b00331ae5aaa511db255b9628cdbc24a53acf','https://img.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg?w=1060&t=st=1691171098~exp=1691171698~hmac=3bfb31089a23c7654b9be3b27303eeb011cac4629285b5c36b545004bd0a9681','write your bio ...');
      emit(succsess_Register_state());
    }
    ).catchError((error){
      print(error.toString());
    });

  }


  void createuser(String name,String email,String phone,String? uId,String image,String cover,String bio){

    UserModel model=UserModel(name, email, phone, uId,image,cover,bio);


FirebaseFirestore.instance.collection('user').doc(uId).set(model.toMap()).then((value){
  emit(succsess_CrateUser_state());
}).catchError((error){
  print('errrrrrrror create');
  print(error.toString());
});

  }

  void login(String email,String password){

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      print('Invalid email format');
      return;
    }

    emit(Loading_login_state());
    print('sasasa');


    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print('loginnnnnnnnnn');
      print(value.user?.email);
      print(value.user?.uid);
      if(value.user?.uid is String){
        print('loveeeeeee');
      }
      uId=value.user?.uid;
      CachHelper.savedata(key: 'uId',value: value.user?.uid);
      emit(succsess_login_state(value.user!.uid));
    }
    ).catchError((error){
      print('errrrroorrr login');
      print(error.toString());
    });

  }

}