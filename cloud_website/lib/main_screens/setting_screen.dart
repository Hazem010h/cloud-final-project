import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/main_screens/setting/change_password.dart';
import 'package:cloud_website/main_screens/setting/edit_profile.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=MainCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.userModel!=null,
              builder: (context){
                return Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Hello: ${cubit.userModel!.name}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Email: ${cubit.userModel!.email}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                              width: MediaQuery.of(context).size.width*0.6,
                              label: 'Change password',
                              function: (){
                                navigateTo(
                                  context: context,
                                  screen: const ChangePasswordScreen(),
                                );
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                              width: MediaQuery.of(context).size.width*0.6,
                              label: 'Edit profile',
                              function: (){
                                navigateTo(
                                  context: context,
                                  screen: const EditProfileScreen(),
                                );
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                              width: MediaQuery.of(context).size.width*0.6,
                              label: 'Logout',
                              function: (){
                                cubit.logout(context: context);
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                            backColor: Colors.red,
                              width: MediaQuery.of(context).size.width*0.6,
                              label: 'Delete Account',
                              function: (){
                                cubit.deleteAccount(context: context);
                              }
                          ),



                        ],
                      ),
                    ),
                  ),
                );
              },
              fallback: (context)=>const Center(child: CircularProgressIndicator(),)
          );
        }
    );
  }
}
