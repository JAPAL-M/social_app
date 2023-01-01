import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/cubit/Social/states.dart';

class EditProfileScreen extends StatelessWidget {
  var NameController = TextEditingController();
  var BioController = TextEditingController();
  var PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialGetUserDataSuccess)
            Navigator.pop(context);
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        NameController.text = cubit.model!.name.toString();
        BioController.text = cubit.model!.bio.toString();
        PhoneController .text = cubit.model!.phone.toString();
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            titleSpacing: 0.0,
            actions: [
              TextButton(
                  onPressed: () {
                    cubit.UpdateUser(
                        name: NameController.text,
                        phone: PhoneController.text,
                        bio: BioController.text);
                  },
                  child: Text(
                    'UPDATE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: 15,
              )
            ],
            leading: InkWell(child: Icon(IconBroken.Arrow___Left_2),onTap: (){Navigator.pop(context);},),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: 243,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 190,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: cubit.coverImage == null
                                        ? NetworkImage(
                                            cubit.model!.cover.toString())
                                        : FileImage(
                                                File(cubit.coverImage!.path))
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  child: InkWell(
                                    child: Icon(IconBroken.Camera),
                                    onTap: () {
                                      cubit.getCoverImage();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 61,
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage(
                                        cubit.model!.image.toString())
                                    : FileImage(File(cubit.profileImage!.path))
                                        as ImageProvider,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  child: InkWell(
                                    child: Icon(IconBroken.Camera),
                                    onTap: () {
                                      cubit.getProfileImage();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if(cubit.profileImage != null || cubit.coverImage != null)
                 SizedBox(
                  height: 10,
                ),
                 Row(
                  children: [
                    SizedBox(width: 8,),
                    if(cubit.profileImage != null)
                     Expanded(child: defaultButton(onPressed: (){
                       try{
                         cubit.UploadProfileImage();
                         ShowMotionToastSuccess(context, 'Success Please Click Update');
                       }catch(e){
                         ShowMotionToastError(context, e.toString());
                       }
                     }, text: 'UPDATE PROFILE')),
                    SizedBox(width: 8,),
                    if(cubit.coverImage != null)
                     Expanded(child: defaultButton(onPressed: (){
                       try{
                         cubit.UploadCoverImage();
                         ShowMotionToastSuccess(context, 'Success Please Click Update');
                       }catch(e){
                         ShowMotionToastError(context, e.toString());
                       }
                     }, text: 'UPDATE COVER')),
                    SizedBox(width: 8,),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultTextFormField(
                      controller: NameController,
                      label: 'Name',
                      type: TextInputType.name,
                      perfixicon: IconBroken.Profile,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Name Please';
                        }
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultTextFormField(
                      controller: BioController,
                      label: 'Bio',
                      type: TextInputType.name,
                      perfixicon: IconBroken.Info_Circle,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Bio Please';
                        }
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultTextFormField(
                      controller: PhoneController,
                      label: 'Phone',
                      type: TextInputType.phone,
                      perfixicon: IconBroken.Call,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Phone Please';
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
