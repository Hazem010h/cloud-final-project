import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=MainCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                  'Setting'
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Text(
                      //   'Hello: ${cubit.userModel!.user!.name}',
                      //   style: const TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w900
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   'Email: ${cubit.userModel!.user!.email}',
                      //   style: const TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w900
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: 30,
                          label: 'Change password',
                          function: (){

                          }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: 30,
                          label: 'Edit profile',
                          function: (){

                          }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: 30,
                          label: 'Logout',
                          function: (){
                            cubit.logout(context: context);
                          }
                      ),


                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
