import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/cubit/Social/states.dart';

import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class PostPage extends StatelessWidget {
  var PostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccess){
          PostController.clear();
          showToast(color: Colors.black.withOpacity(.6),text: 'Post is created');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            titleSpacing: 0.0,
            leading: InkWell(
              child: Icon(IconBroken.Arrow___Left_2),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if(cubit.postImage != null){
                      cubit.UploadPostImage(text: PostController.text);
                    }else{
                      cubit.CreatePost(text: PostController.text);
                    }
                  },
                  child: Text(
                    'POST',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: Column(
            children: [
              if(state is SocialCreatePostLoading)
               SizedBox(height: 5,),
              if(state is SocialCreatePostLoading)
               LinearProgressIndicator(),
              if(state is SocialCreatePostLoading)
               SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            SocialCubit.get(context).model!.image.toString()),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(cubit.model!.name.toString()),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: PrimaryColor,
                                size: 15,
                              )
                            ],
                          ),
                          Text(
                            'Public',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextFormField(
                    controller: PostController,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Enter Your Post Please';
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      hintText: 'What is on your mind....',
                    ),
                  ),
                ),
              ),
             if(cubit.postImage != null)
               Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 6,
                      margin: EdgeInsets.all(3),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: FileImage(
                                File(cubit.postImage!.path))
                            as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        cubit.removePostImage();
                      },
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text('# tags')))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
