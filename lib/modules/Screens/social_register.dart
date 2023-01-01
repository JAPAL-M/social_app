import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/Register/cubit.dart';
import '../../shared/cubit/Register/states.dart';

class RegisterScreen extends StatelessWidget {

  var EmailController = TextEditingController();
  var PassController = TextEditingController();
  var NameController = TextEditingController();
  var PhoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is UserCreateSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              uId = state.uId;
              navigateAndFinish(context, SocialLayout());
              ShowMotionToastSuccess(context, 'Register is done');
            });
          }else if (state is RegisterErrorState){
            ShowMotionToastError(context, state.error);
          }
        },
        builder: (context,state){
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                            'register now to communicate with friends',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: NameController,
                            label: 'Name',
                            type: TextInputType.name,
                            perfixicon: IconBroken.User,
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Name Is Empty';
                            }
                        ),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: PhoneController,
                            label: 'Phone',
                            type: TextInputType.phone,
                            perfixicon: IconBroken.Call,
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Phone Is Empty';
                            }
                        ),
                        SizedBox(height: 15,),
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
                            controller: PassController,
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            perfixicon: IconBroken.Unlock,
                            obscureText: RegisterCubit.get(context).isPassword,
                            suffixicon: IconButton(
                              onPressed: (){
                                RegisterCubit.get(context).changeVisibility();
                              },
                              icon: Icon(RegisterCubit.get(context).suffix),
                            ),
                            validator: (String? value){
                              if(value!.isEmpty)
                                return 'Password Is Empty';
                            }
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: (){
                           if(formkey.currentState!.validate()) {
                             RegisterCubit.get(context).registerUser(
                                 name: NameController.text,
                                 phone: PhoneController.text,
                                 email: EmailController.text,
                                 pass: PassController.text
                             );
                           }
                            },
                            text: 'SIGN UP',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text('Login Now')
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
