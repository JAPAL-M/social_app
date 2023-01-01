import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/ChatCreate.dart';
import 'package:social_app/models/PostCreate.dart';
import 'package:social_app/models/PostCreate.dart';
import 'package:social_app/models/UserCreate.dart';
import 'package:social_app/modules/Home/Chat_screen.dart';
import 'package:social_app/modules/Home/Home_screen.dart';
import 'package:social_app/modules/Home/Settings_screen.dart';
import 'package:social_app/modules/Home/Users_screen.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/cubit/Social/states.dart';
import 'package:social_app/shared/network/remote/Dio_Helper.dart';

import '../../../modules/Home/Post_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserCreate? model;

  void getUserData() {
    emit(SocialGetUserDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserCreate.fromJson(value.data()!);
      emit(SocialGetUserDataSuccess());
    }).catchError((error) {
      emit(SocialGetUserDataError(error.toString()));
    });
  }

  List<Widget> screens = [
    HomePage(),
    ChatPage(),
    PostPage(),
    UsersPage(),
    SettingsPage(),
  ];

  List<String> title = [
    'Home',
    'Chat',
    '',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;

  void ChangeBottamNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(ChangeBottomNavToPost());
    } else {
      currentIndex = index;
      emit(ChangeBottomNav());
    }
  }

  File? profileImage;
  var Picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedImage = await Picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(AddPhotoProfileSuccess());
    } else {
      emit(AddPhotoProfileError());
      print('no image');
    }
  }

  File? coverImage;
  var PickerCover = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedCover =
    await PickerCover.pickImage(source: ImageSource.gallery);

    if (pickedCover != null) {
      coverImage = File(pickedCover.path);
      emit(AddPhotoCoverSuccess());
    } else {
      emit(AddPhotoCoverError());
      print('no image');
    }
  }

  String ProfileImUp = '';

  void UploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        ProfileImUp = value.toString();
        emit(UploadPhotoProfileSuccess());
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((e) {
      print(e.toString());
      emit(UploadPhotoProfileError());
    });
  }

  String CoverImUp = '';

  void UploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CoverImUp = value.toString();
        emit(UploadPhotoCoverSuccess());
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((e) {
      print(e.toString());
      emit(UploadPhotoCoverError());
    });
  }

  void UpdateUser({
    String? name,
    String? phone,
    String? image,
    String? cover,
    String? bio,
  }) async{
    UserCreate data = UserCreate(
      token: await FirebaseMessaging.instance.getToken(),
      name: name,
      phone: phone,
      image: ProfileImUp == '' ? model!.image : ProfileImUp,
      email: model!.email,
      uid: model!.uid,
      bio: bio,
      cover: CoverImUp == '' ? model!.cover : CoverImUp,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .update(data.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      print(e.toString());
    });
  }

  File? postImage;
  var PickerPost = ImagePicker();

  Future<void> getPostImage() async {
    final pickedPost = await PickerPost.pickImage(source: ImageSource.gallery);

    if (pickedPost != null) {
      postImage = File(pickedPost.path);
      emit(AddPhotoPostSuccess());
    } else {
      emit(AddPhotoPostError());
      print('no image');
    }
  }

  void UploadPostImage({
    String? text,
    String? datetime,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(
            text: text, postimage: value, datetime: DateTime.now().toString());
        removePostImage();
        emit(UploadPhotoPostSuccess());
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((e) {
      print(e.toString());
      emit(UploadPhotoPostError());
    });
  }

  void CreatePost({
    String? text,
    String? datetime,
    String? postimage,
  }) {
    likes = [];
    emit(SocialCreatePostLoading());
    PostModel data = PostModel(
        name: model!.name,
        text: text,
        uid: uId,
        Profileimage: model!.image,
        Postimage: postimage ?? '',
        datetime: DateTime.now().toString());
    FirebaseFirestore.instance
        .collection('posts')
        .add(data.toMap())
        .then((value) {
      GetPost();
      removePostImage();
      emit(SocialCreatePostSuccess());
    }).catchError((e) {
      emit(SocialCreatePostError(e.toString()));
      print(e.toString());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImage());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void GetPost() {
    posts = [];
    likes = [];
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((value) async {
      value.docs.forEach((element) {
        posts = [];
        element.reference.collection('likes').snapshots().listen((value) async {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostSuccess());
        });
      });
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uid)
        .set({
      'like': true,
    }).then((value) {
      GetPost();
      emit(SocialGetLikesSuccess());
    }).catchError((error) {
      emit(SocialGetLikesError());
    });
  }

  List<UserCreate> users = [];

  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != model!.uid)
          users.add(UserCreate.fromJson(element.data()));
        emit(SocialGetUsersSuccess());
      });
    }).catchError((onError) {
      emit(SocialGetUsersError());
    });
  }
 ChatModel? chatsmodel;
  void Chat({
    required String name,
    required String token,
    required String text,
    required String datetime,
    required String reciverId,
    String? senderId,
  }) async{
    ChatModel chat = ChatModel(
        text: text,
        datetime: datetime,
        reciverId: reciverId,
        senderId: model!.uid,
        token: await FirebaseMessaging.instance.getToken()
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chat')
        .doc(reciverId)
        .collection('messages')
        .add(chat.toMap())
        .then((value) {
      emit(SocialChatSuccess());
    })
        .catchError((onError) {
      emit(SocialChatError());
      print(onError);
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chat')
        .doc(model!.uid)
        .collection('messages')
        .add(chat.toMap())
        .then((value) {
      sendnotify(chat,model!.name,token);
      emit(SocialChatSuccess());
    })
        .catchError((onError) {
      emit(SocialChatError());
      print(onError);
    });
  }
 List<ChatModel> chat = [];
  void getChat(reciverId) {
    FirebaseFirestore.instance.collection('users').doc(model!.uid).collection(
        'chat').doc(reciverId).collection('messages').orderBy('datetime',descending: true).snapshots().listen((
        event) {
          chat = [];
          event.docs.forEach((element) {
            chat.add(ChatModel.fromJson(element.data()));
          });
      emit(SocialGetChatSuccess());
    });
  }
  
  void sendnotify(ChatModel msg,name,token)async{
    DioHelper.postData(url: '/fcm/send', data: {
      "to": token,
      "notification":
      {
        "title": name,
        "body": msg.text,
        "sound": "default"
      },
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAC",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {
        "type": "order",
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    }).then((value){
      print(value);
      emit(SenNotifySuccess());
      print(value);
    }).catchError((onError){
      emit(SenNotifyError());
      print(onError);
    });
  }
      }


