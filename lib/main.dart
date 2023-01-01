import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' ;
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/Screens/social_login.dart';
import 'package:social_app/modules/Screens/social_onBoarding.dart';
import 'package:social_app/shared/BlocObserver/Bloc_Observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/cubit/Social/cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/Dio_Helper.dart';
import 'package:social_app/shared/style/theme.dart';
import 'firebase_options.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  showToast(text: 'text', color: Colors.grey);

  print("Handling a background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

  });
  await CacheHelper.init();
  Widget widget;
  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');

  uId = CacheHelper.getData(key: 'uId') == null ? '' : CacheHelper.getData(key: 'uId');

  if(onBoarding != null){
    if(uId != null){
      widget = SocialLayout();
    }else {
      widget = LoginScreen();
    }
  }else{
    widget = onBoadingScreen();
  }
  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startwidget;

  MyApp({this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUserData()..GetPost()..getUsers(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        darkTheme: themDark,
        theme: themLight,
        home: startwidget,
      ),
    );
  }

}




