import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/UserCreate.dart';
import 'package:social_app/shared/cubit/Register/states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super (RegisterIntialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
  @required String? name,
  @required String? phone,
  @required String? email,
  @required String? pass,
})async{
    emit(RegisterLoadingState());
    try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: pass!,
      ).then((value){
         UserAdd(name: name, phone: phone, email: email, uid: value.user!.uid);
       });
    } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      emit(RegisterErrorState('Password is too weak'));
    } else if (e.code == 'email-already-in-use') {
    emit(RegisterErrorState('Email already used'));
    }
    } catch (e) {
    print(e);
    }
  }

  void UserAdd({
    @required String? token,
    @required String? name,
    @required String? phone,
    @required String? email,
    @required String? uid,
})async{
    emit(UserCreateLoadingState());
    UserCreate model = UserCreate(
      token: await FirebaseMessaging.instance.getToken(),
      name: name,
      email: email,
      bio: 'write bio ...',
      cover: 'https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984797.jpg?t=st=1672068876~exp=1672069476~hmac=bfc7f1bf28b6418a3b83acb91de41d340542651f017afcb3508c6a5e7e79442f',
      image: 'https://img.freepik.com/premium-photo/young-handsome-man-playing-with-video-game-controller-isolated-pink-background-shaking-hands-closing-good-deal_1368-342566.jpg',
      phone: phone,
      uid: uid,
    );

    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value){
      emit(UserCreateSuccessState(uid.toString()));
    }).catchError((e){
      print(e.toString());
      emit(UserCreateErrorState(e.toString()));
    });
  }


  IconData suffix = IconBroken.Hide;
  bool isPassword = true;

  void changeVisibility (){
    isPassword = !isPassword;
    suffix =  isPassword ? IconBroken.Hide : IconBroken.Show;
    emit(ChangeIconPassRe());
  }

}