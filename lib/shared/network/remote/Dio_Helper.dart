import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
 static Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    @required String? url,
     Map<String,dynamic>? query,
     @required Map<String,dynamic>? data,
}) async {
    dio!.options.headers = {
    'Content-Type':'application/json',
      'Authorization' : 'key=AAAArRTVQqg:APA91bEq2LhG7ot6nzKcuJYLYorG9p-WIJf5hkQgz_7Z_JD37z_FeGCevk1bnIGZh-53GuI-IJy9fKJfsY9YCOyFf93Vr77NSVhR0wHhEnSQhXEvk5i-iv_71NDZSONi9d5_l4cCa95Q',
    };
   return dio!.post(url!,queryParameters: query,data: data);
  }
}