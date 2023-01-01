import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/Home/Edit_Profile.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/cubit/Social/states.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialCubit.get(context);
       return Scaffold(
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
                          child: Image( image: NetworkImage(
                             cubit.model!.cover.toString() ),
                            fit: BoxFit.cover,
                            height: 190,
                            width: double.infinity,
                          ),
                        ),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 61,
                            backgroundImage: NetworkImage(
                                cubit.model!.image.toString()
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(cubit.model!.name.toString(),style: Theme.of(context).textTheme.bodyText1,),
                Text(cubit.model!.bio.toString(),style: Theme.of(context).textTheme.caption,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('100',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Posts',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('256',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Photos',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('100k',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Followers',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('67',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Following',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          width: 300,
                          child: OutlinedButton(
                          onPressed: (){

                          },
                          child: Text('Add Photo',style: TextStyle(fontWeight: FontWeight.bold),)
                      )
                      ),
                      SizedBox(width: 10,),
                      Container(
                          child: OutlinedButton(
                              onPressed: (){
                                navigateto(context, EditProfileScreen());
                              },
                              child: Icon(IconBroken.Edit)
                          )
                       ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
