import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/PostCreate.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/cubit/Social/states.dart';
import 'package:social_app/shared/style/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: cubit.posts != null,
              builder: (context) => Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 6,
                    margin: EdgeInsets.all(8),
                    child: Image.network('https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=1380&t=st=1671935716~exp=1671936316~hmac=fd76bc0c1a14a7611c72649b193962e91a0de8c100e063a18e2f693ef9869a32'),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) => buildPost(cubit.posts[index],context,index),
                      separatorBuilder: (context,index) => myDivider(),
                      itemCount: cubit.posts.length
                  )
                ],
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget buildPost(PostModel post,context,index) {
   return Card(
      elevation: 6,
      child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(post.Profileimage.toString()),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(post.name.toString()),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle,color: PrimaryColor,size: 15,)
                        ],
                      ),
                      Text(post.datetime.toString(),style: TextStyle(fontSize: 12,color: Colors.grey),)
                    ],
                  ),
                ),
                Icon(Icons.more_horiz_outlined),
                SizedBox(width: 15,)
              ],
            ),
            SizedBox(height: 10,),
            myDivider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(post.text.toString(),
                  style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Container(
            //margin: EdgeInsets.symmetric(horizontal: 8),
            // width: double.infinity,
            //  child: Wrap(
            //    children: [
            //Padding(
            //padding: const EdgeInsets.only(right: 4.0),
            // child: MaterialButton(
            //     onPressed: (){},
            //  minWidth: 1,
            //   height: 25,
            //   padding: EdgeInsets.zero,
            //   child: Text('#software',style: TextStyle(color: PrimaryColor),),
            //    ),
            //),
            if(post.Postimage != '')       //
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 6,
                margin: EdgeInsets.all(8),
                child: Image.network(post.Postimage.toString(),width: double.infinity,fit: BoxFit.fill,),
              ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                    child: InkWell(
                      onTap: (){
                          SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,color: Colors.red,),
                          SizedBox(width: 5,),
                          Text('${SocialCubit.get(context).likes[index]}'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 8),
                    child: InkWell(
                      onTap: (){

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,color: Colors.amber,),
                          SizedBox(width: 5,),
                          Text('0 Comments'),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            myDivider(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(SocialCubit.get(context).model!.image.toString()),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Write a comment...',
                          hintStyle: TextStyle(fontSize: 14)
                      ),
                    )
                ),
                Icon(IconBroken.Heart,color: Colors.red,size: 18,),
                SizedBox(width: 5,),
                Text('Like',style: TextStyle(fontSize: 12),),
                SizedBox(width: 15,),
                Icon(IconBroken.Upload,color: Colors.cyanAccent,size: 18,),
                SizedBox(width: 5,),
                Text('Share',style: TextStyle(fontSize: 12),),
                SizedBox(width: 15,)
              ],
            ),
          ]
      ),
    );
  }
}
