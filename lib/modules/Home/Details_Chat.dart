import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/ChatCreate.dart';
import 'package:social_app/models/UserCreate.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';

import '../../shared/cubit/Social/states.dart';
import '../../shared/style/colors.dart';

class DetailsChat extends StatefulWidget {
  UserCreate? usermodel;

  DetailsChat({this.usermodel});


  @override
  State<DetailsChat> createState() => _DetailsChatState();
}

class _DetailsChatState extends State<DetailsChat> {
  var formkey = GlobalKey<FormState>();
  String? nul;

  var textController = TextEditingController();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    SocialCubit.get(context).getChat(widget.usermodel!.uid);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialChatSuccess)
          textController.clear();
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.usermodel!.image.toString()),
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
                        Text(
                          widget.usermodel!.name.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
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
                  ],
                ),
              ),
            ]),
          ),
          body: Form(
            key: formkey,
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: cubit.chat != null,
                  builder:(context) => Expanded(
                    child: ListView.separated(
                      reverse: true,
                        controller: _controller,
                        itemBuilder: (context,index) {
                          if(cubit.model!.uid != cubit.chat[index].senderId){
                            return buildMyMessage(cubit.chat[index]);
                          }else{
                            return buildMessage(cubit.chat[index]);
                          }
                        },
                        separatorBuilder: (context,index) => SizedBox(height: 15,),
                        itemCount: SocialCubit.get(context).chat.length
                    ),
                  ),
                  fallback: (context) => Center(child: Text('Start Send Message',style: Theme.of(context).textTheme.headline5,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFF413F3F),
                            width: 1.0
                        ),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (String? value){
                              if(!value!.isEmpty)
                                setState(() {
                                  nul = 'x';
                                });
                              else
                                setState(() {
                                  nul = null;
                                });
                            },
                            controller: textController,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) return 'Message is Empty!!';
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(13),
                                hintText: 'Write your message....',
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          height: 55.9,
                          color: PrimaryColor,
                          child: nul == null ? Container() : MaterialButton(
                            onPressed: () {
                              if(formkey.currentState!.validate()) {
                                cubit.Chat(token: widget.usermodel!.token.toString(),name: widget.usermodel!.name.toString(),text: textController.text,
                                    datetime: DateTime.now().toString(),
                                    reciverId: widget.usermodel!.uid
                                        .toString());
                                _controller.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              }
                            },
                            minWidth: 1.0,
                            child: Icon(
                              IconBroken.Send, color: Colors.white, size: 19,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMyMessage(ChatModel chat) => Align(
    alignment: AlignmentDirectional.topStart,
    child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        child: Text(chat.text.toString(),
            style: TextStyle(color: Colors.white))),
  );

  Widget buildMessage(ChatModel chat) => Align(
    alignment: AlignmentDirectional.topEnd,
    child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.cyan[800],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8))),
        child: Text(
          chat.text.toString(),
          style: TextStyle(color: Colors.white),
        )),
  );
}
