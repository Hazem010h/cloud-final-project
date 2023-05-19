import 'package:bloc/bloc.dart';
import 'package:cloud_website/login_screen/login_screen.dart';
import 'package:cloud_website/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

