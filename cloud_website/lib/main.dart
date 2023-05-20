import 'package:cloud_website/login_screen/login_screen.dart';
import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/layout/layout.dart';
import 'package:cloud_website/shared/bloc_observer.dart';
import 'package:cloud_website/shared/components/constants.dart';
import 'package:cloud_website/shared/network/local/cache_helper.dart';
import 'package:cloud_website/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await CacheHelper.init();
  uId=CacheHelper.getData(key: 'uId');
  Widget widget;
   DioHelper.init();
  if(uId!=null){
    widget=const LayoutScreen();
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
    return  BlocProvider(
      create: (BuildContext context)=>MainCubit()..getUserData()..getProducts(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startPage,
      ),
    );
  }
}

