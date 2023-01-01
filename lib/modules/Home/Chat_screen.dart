import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/UserCreate.dart';
import 'package:social_app/modules/Home/Details_Chat.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/cubit/Social/states.dart';

import '../../shared/style/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = SocialCubit.get(context);
          return Scaffold(
            body: ListView.separated(
                itemBuilder: (context,index) => buildUser(cubit.users[index],context),
                separatorBuilder: (context,index) => myDivider(),
                itemCount: cubit.users.length
            ),
          );
        },
    );
  }

  Widget buildUser(UserCreate model,context) => InkWell(
    onTap: (){
      navigateto(context, DetailsChat(usermodel: model,));
    },
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(model.image.toString()),
          ),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(model.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Icon(Icons.check_circle,color: PrimaryColor,size: 15,)
                ],
              ),
            ],
          ),
        ),
      ]
    ),
  );
}
