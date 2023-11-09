
import 'dart:io';


import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/message_model.dart';
import 'package:firebase/models/post_model.dart';
import 'package:firebase/modules/addpost/add_post.dart';
import 'package:firebase/modules/chats/chats_screen.dart';
import 'package:firebase/modules/feeds/feeds_screen.dart';
import 'package:firebase/modules/settings/settings_screen.dart';
import 'package:firebase/modules/users/users_screen.dart';

import 'package:firebase/shared/appcubit/appstates.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {


  AppCubit() : super(appinitialstate());

  static AppCubit get(context) => BlocProvider.of(context);


  UserModel user=UserModel('', '', '', '', '', '', '');

  int currentindex=0;

  List<Widget> screens=[
    Feeds_Screen(),
    Chats_Screen(),
    Users_Screen(),
    Add_Post(),
    Settings_Screen(),

  ];

  List<String> titles=[
    'Home',
    'Chats',
    'Users',
    'Posts',
    'Settings',


  ];
  String userid='';

 void getuser(String uId){

   emit(Loading_Getuser_state());
   FirebaseFirestore.instance.collection('user').doc(uId).get().then((value){
     print('ussssssssssserrrr datttttttta');
     print(value.data());
     user = UserModel.fromjson(value.data()!);
     print(user.name);
     userid=user.uId!;
     emit(succsess_Getuser_state());
   }).catchError((error){
     print('//////errrrrrrrrror get user/////');
     print(error.toString());
   });

 }

 File profileimage=File('');
 var picker=ImagePicker();

 Future<void> getProfileImage()async{

   final pickedFile=await picker.pickImage(source: ImageSource.gallery);

   if(pickedFile !=null){
     profileimage=File(pickedFile.path);
     emit(succsess_Pickimage_state());
   }
 }

  File coverimage=File('');
  Future<void> getCoverImage()async{

    final pickedFile=await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null){
      profileimage=File(pickedFile.path);
      emit(succsess_Pickcoverimage_state());
    }
  }

  String coverimageUrl='';
  void uploadcoverimage({ required String? name,required String? phone,required String? bio}){
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(coverimage.path).pathSegments.last}')
        .putFile(coverimage).then((value) => {
          value.ref.getDownloadURL().then((value) => {
            coverimageUrl=value,
            updateuser(name:name , phone: phone, bio: bio,cover: coverimageUrl),
            emit(succsess_Upoladcoverimage_state()),
            //getuser(userid),
          }).catchError((error){
            print(error.toString());
          })
    }).catchError((error){
      print(error.toString());
    });
  }

  String profileimageUrl='';
  void uploadprofileimage({ required String? name,required String? phone,required String? bio}){
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileimage.path).pathSegments.last}')
        .putFile(profileimage).then((value) => {
      value.ref.getDownloadURL().then((value) => {
        profileimageUrl=value,
        updateuser(name:name , phone: phone, bio: bio,image: profileimageUrl),
        emit(succsess_Upoladprofileimage_state()),
        //getuser(userid),
      }).catchError((error){
        print(error.toString());
      })
    }).catchError((error){
      print(error.toString());
    });
  }


  void updateuser({ required String? name,required String? phone,required String? bio,String? cover,String? image}) {
    
      UserModel model = UserModel(
          name,
          user.email,
          phone,
          user.uId,
          image??user.image,
          cover??user.cover,
          bio);

      FirebaseFirestore.instance.collection('user').doc(user.uId).update(
          model.toMap()).then((value) => {
      //getuser(user.uId);
        print('updaaaaaaaaaaateeeeeeeeeedddd'),
        getuser(userid),
        emit(succsess_Upoladdata_state())
      }).catchError((error) {
        print(error.toString());
      });
    
  }

  File postimage=File('');
  Future<void> getPostImage()async{

    final pickedFile=await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null){
      postimage=File(pickedFile.path);
      emit(succsess_Pickpostimage_state());
    }
  }


  void createPost({ required String? dateTime,required String? text,String? postimage}) {
    emit(Loading_Createpost_state());

    PostModel model = PostModel(
       user.name,
        user.uId,
        user.image,
        dateTime,
        text,
      postimage??'',
    );

    FirebaseFirestore.instance.collection('posts').add(
        model.toMap()).then((value) => {
      //getuser(user.uId);
      print('posteeeeeeeeeeeeed'),
      //getuser(userid),
      emit(succsess_Createpost_state()),
      getPosts(),

    }).catchError((error) {
      print(error.toString());
    });

  }

  void uploadpostimage({ required String? dateTime,required String? text}){
    emit(Loading_Upoladpostimage_state());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!).then((value) => {
      value.ref.getDownloadURL().then((value) => {

        createPost(dateTime: dateTime, text: text,postimage: value),
        emit(succsess_Upoladpostimage_state()),
        posts=[],
        getPosts(),
        //getuser(userid),
      }).catchError((error){
        print(error.toString());
      })
    }).catchError((error){
      print(error.toString());
    });
  }

void removePostimage(){
    postimage = File('');
    emit(Remove_Postimage_state());
}

  int partition(List<PostModel> posts, int low, int high) {
    PostModel pivot = posts[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      if (posts[j].dateTime!.compareTo(pivot.dateTime!) <= 0) {
        i++;
        // Swap posts[i] and posts[j]
        PostModel temp = posts[i];
        posts[i] = posts[j];
        posts[j] = temp;
      }
    }

    // Swap posts[i+1] and posts[high] (pivot)
    PostModel temp = posts[i + 1];
    posts[i + 1] = posts[high];
    posts[high] = temp;

    return i + 1;
  }

  void quickSortPosts(List<PostModel> posts, int low, int high) {
    if (low < high) {
      int pivotIndex = partition(posts, low, high);
      quickSortPosts(posts, low, pivotIndex - 1);
      quickSortPosts(posts, pivotIndex + 1, high);
    }
  }


List<PostModel> posts=[];
  List<String> postsid=[];
  List<int>likes=[];
  List<int>comments=[];
  int count=0;
  List<String> elemnts=[];

  void getPosts(){
  posts=[];
  likes=[];
  comments=[];
  elemnts=[];
  count=0;
  emit(Loading_getposts_state());
  FirebaseFirestore.instance.collection('posts').get().then((value) => {
    value.docs.forEach((element) {
      print(element.id);

      element.reference.collection('likes').get().then((valuee){
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          likes.add(valuee.docs.length);
          postsid.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
          valuee.docs.forEach((element) {
            elemnts.add(element.id);
            print(elemnts[count]);
            count++;
          });
        }).catchError((error){
          print(error.toString());
        });

      }).catchError((error){
        print(error.toString());
      });


  /*if (element.reference.collection('likes') != null) {
  element.reference.collection('likes'). get ().then((value) =>
  {
  likes.add(value.docs.length),
  postsid.add(element.id),
  posts.add(PostModel.fromjson(element.data())),
    count++,
  if (element.reference.collection('comments') != null){
    element.reference.collection('comments'). get().then((value) => {
      comments.add(value.docs.length),
    }).catchError((error) {
    print('error comments');
    print(error.toString());
  })
  }else{
    comments.add(0),
  }
  });
  }

  if (element.reference.collection('comments') != null &&
  element.reference.collection('likes') == null) {
  element.reference.collection('comments'). get ().then((value) =>
  {
  comments.add(value.docs.length),
    likes.add(0),
  postsid.add(element.id),
  posts.add(PostModel.fromjson(element.data())),
    count++,
  }).catchError((error) {
  print('error comments');
  print(error.toString());
  });
  }
 if (element.reference.collection('likes') == null &&
  element.reference.collection('comments') == null) {
   comments.add(0);
   likes.add(0);
  postsid.add(element.id);
  posts.add(PostModel.fromjson(element.data()));
  count++;
  }
  count=0;
  if(count==value.docs.length){
    print('done');
  }
  else{
    print('not done');
    print(count);

  }*/
  }
  ),

    emit(succsess_getposts_state()),

    // eloshhkellaaa   henaaaaaaaaaa
    /*if (posts.length > 0) {
      print(posts[0].dateTime!),
      print(posts[1].dateTime!),
      if (posts[0].dateTime!.compareTo(posts[1].dateTime!) <= 0) {
        print(posts[0].dateTime),
        print('truueeeeeeeeeeeeeeeeeeeeeeeeeeeeee'),
      } else {
        print('falseeeeeeeeeeeeeeeeeeeeeeee'),
      }
    } else {
      // Handle case where there are no documents
      print('No documents found'),

    },*/

  //quickSortPosts(posts, 0, posts.length - 1),
  }).catchError((error){
    print ('error  get posts');
    print(error.toString());
  });

}


  Color heart=Colors.grey;
  //doc(user.uId)

  void likePost(String postid){

    FirebaseFirestore.instance.collection('posts').doc(postid).collection('likes').doc(user.uId).set({
      'like':true,
    }).then((value) => {
          //heart = Colors.red,
      emit(succsess_likepost_state()),
      getPosts(),

    }).catchError((error){
      print(error.toString());
    });
  }

  void CommentPost(String postid,String text){

    FirebaseFirestore.instance.collection('posts').doc(postid).collection('comments').doc(user.uId).set({
      'comment':text,
    }).then((value) => {
      //heart = Colors.red,
      emit(succsess_addComment_state()),
      getPosts(),

    }).catchError((error){
      print(error.toString());
    });
  }


List<UserModel> usersmodel=[];
void getUsers(){
  if(usersmodel.length==0) {
    emit(Loading_getAllusers_state());
    FirebaseFirestore.instance.collection('user').get().then((value) =>
    {
      value.docs.forEach((element) {
        usersmodel.add(UserModel.fromjson(element.data()));
      }),
      emit(succsess_getAllusers_state()),
    }).catchError((error) {
      print(error.toString());
    });
  }
}

void SendMessage(receiverId,dateTime,text){
  MessageModel message=MessageModel(receiverId, user.uId, dateTime, text);



  FirebaseFirestore.instance.collection('user').doc(user.uId)
  .collection('chats').doc(receiverId).collection('messages').add(message.toMap())
  .then((value) => {
    emit(succsess_sendMessage_state()),
  }).catchError((error){
    print(error.toString());
    emit(Error_sendMessage_state());
  });

//reciver side
  FirebaseFirestore.instance.collection('user').doc(receiverId)
      .collection('chats').doc(user.uId).collection('messages').add(message.toMap())
      .then((value) => {
    emit(succsess_sendMessage_state()),
  }).catchError((error){
    print(error.toString());
    emit(Error_sendMessage_state());
  });
}

List<MessageModel> messages=[];

void getMessages(String receiverId){
  FirebaseFirestore.instance.collection('user')
      .doc(user.uId).collection('chats').doc(receiverId).collection('messages').orderBy('dateTime')
      .snapshots().listen((event) {
        messages=[];
        event.docs.forEach((element) {
          messages.add(MessageModel.fromjson(element.data()));
        });
        emit(succsess_getMessages_state());
        print(messages);
  });
}


 void changenav(int index){
   currentindex=index;
   if(index==1){
     getUsers();
   }

   emit(ChangeBootomNav_state());
 }

}



/*void likePost(String postid){

  FirebaseFirestore.instance.collection('posts').doc(postid).collection('likes').doc(user.uId).set({
    'like':true,
  }).then((value) => {
    if(heart==Colors.red){
      FirebaseFirestore.instance.collection('posts').doc(postid).collection('likes').doc(user.uId).delete().then((value) => {
        heart=Colors.grey,
        getPosts(),
        emit(succsess_likepost_state()),
      })
    }
    else
      {
        heart = Colors.red,
        getPosts(),
        emit(succsess_likepost_state()),
      }
  }).catchError((error){
    print(error.toString());
  });
}*/


/*void likePost(String postid){

    if(heart==Colors.red){
      FirebaseFirestore.instance.collection('posts').doc(postid).collection('likes').doc(user.uId).delete().then((value) => {
        heart=Colors.grey,
        getPosts(),
        emit(succsess_likepost_state()),
      }).catchError((error) {
        print("Error deleting document: $error");
      });
    }
    else
      {
        FirebaseFirestore.instance.collection('posts').doc(postid).collection('likes').doc(user.uId).set({
          'like':true,
        }).then((value) => {
          heart = Colors.red,
          getPosts(),
          emit(succsess_likepost_state()),
        });
      }

}*/