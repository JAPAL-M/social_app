import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/shared/cubit/Login/states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super (LoginIntialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  void loginrUser({
    @required String? email,
    @required String? pass,
  })async{
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: pass!
      ).then((value){
        updatetoken(value.user!.uid);
        emit(LoginSuccessState(value.user!.uid));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState('No user for that email'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('Wrong password'));
      }
    }
  }

  void updatetoken(uid){
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'token' : FirebaseMessaging.instance.getToken()
    }).then((value){
      emit(UpdateTokenSuccessState());
    });
  }

  IconData suffix = IconBroken.Hide;
  bool isPassword = true;

  void changeVisibility (){
    isPassword = !isPassword;
    suffix =  isPassword ? IconBroken.Hide : IconBroken.Show;
    emit(ChangeIconPass());
  }

}