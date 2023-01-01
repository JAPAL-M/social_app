import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/Login/cubit.dart';
import '../../shared/cubit/Login/states.dart';
import 'package:social_app/modules/Screens/social_register.dart';

class LoginScreen extends StatelessWidget {

  var EmailController = TextEditingController();
  var PassController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState && state is UpdateTokenSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              uId = state.uId;
              navigateAndFinish(context, SocialLayout());
              ShowMotionToastSuccess(context, 'Login Success');
            });
          }else if (state is LoginErrorState){
            ShowMotionToastError(context, state.error);
          }
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                            'login now to communicate with friends',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: EmailController,
                            label: 'Email Address',
                            type: TextInputType.emailAddress,
                            perfixicon: IconBroken.Message,
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Email Address Is Empty';
                            }
                        ),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                            obscureText: cubit.isPassword,
                            controller: PassController,
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            perfixicon: IconBroken.Unlock,
                            suffixicon: IconButton(
                              onPressed: (){
                                cubit.changeVisibility();
                              },
                              icon: Icon(cubit.suffix),
                            ),
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Email Address Is Empty';
                            }
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: (){
                              if(formkey.currentState!.validate()){
                                LoginCubit.get(context).loginrUser(email: EmailController.text, pass: PassController.text);
                              }
                            },
                            text: 'LOGIN',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: (){
                                 navigateto(context, RegisterScreen());
                                },
                                child: Text('Register Now')
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
