import 'package:bloc/bloc.dart';
import 'package:cloud_website/login_screen/login_screen.dart';
import 'package:cloud_website/main_screens/setting_screen.dart';
import 'package:cloud_website/shared/bloc_observer.dart';
import 'package:cloud_website/shared/components/constants.dart';
import 'package:cloud_website/shared/network/local/cache_helper.dart';
import 'package:cloud_website/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

void main() async{
  Bloc.observer=MyBlocObserver();
  await CacheHelper.init();
  uId=CacheHelper.getData(key: 'uId');
  Widget widget;
   DioHelper.init();
  if(uId!=null){
    widget=const SettingScreen();
  }else{
    widget=const LoginScreen();
  }
  runApp( MyApp(startPage: widget));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.startPage});

  Widget ?startPage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startPage,
    );
  }
}

