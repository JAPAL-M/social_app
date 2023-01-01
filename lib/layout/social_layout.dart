import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/Home/Post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/cubit/Social/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is ChangeBottomNavToPost)
          navigateto(context, PostPage());
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
      return  ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text(cubit.title[cubit.currentIndex]),),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat'),
                    BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
                    BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
                    BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Setting'),
                  ],
                onTap: (index){
                    cubit.ChangeBottamNav(index);
                },
                currentIndex: cubit.currentIndex,
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
