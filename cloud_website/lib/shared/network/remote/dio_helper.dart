import 'package:dio/dio.dart';

class DioHelper{
 static Dio ? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData({
  required String url,
  Map<String, dynamic>? query,
    String lang='en',
    String ?token,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':token,
      'lang':lang,
    };
   return await dio!.get(url,queryParameters: query,);
  }

  static Future<Response> postData({
  required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang='en',
    String? token,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':token??'',
      'lang':lang,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
  required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang='en',
    String? token,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':token??'',
      'lang':lang,
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
  required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang='en',
    String? token,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':token??'',
      'lang':lang,
    };
    return await dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }




}