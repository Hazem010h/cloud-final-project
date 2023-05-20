import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_states.dart';

var passwordController=TextEditingController();
var confirmPasswordController=TextEditingController();
var formKey=GlobalKey<FormState>();

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=MainCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  passwordController.clear();
                  confirmPasswordController.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios
                ),
              ),
              centerTitle: true,
              title: const Text(
                'Change password',
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          prefixIcon: const Icon(
                              Icons.key
                          ),
                          controller: passwordController,
                          obscure:cubit.isVisible? false:true,
                          keyboardType: TextInputType.text,
                          label: 'Old password',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'this field mustn\'t be empty';
                            }
                            return null;
                          }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          prefixIcon: const Icon(
                              Icons.key
                          ),
                          controller: confirmPasswordController,
                          obscure:cubit.isVisible? false:true,
                          keyboardType: TextInputType.text,
                          label: 'New password',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'this field mustn\'t be empty';
                            }
                            return null;
                          }
                      ),
                      TextButton(
                          onPressed: (){
                            cubit.changeVisibility();
                          },
                          child:  Text(
                            !cubit.isVisible?'Show password':'Hide password',
                          ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: 30,
                          label: 'Change password',
                          function: (){
                            if(formKey.currentState!.validate()){
                              if(passwordController.text==cubit.userModel!.password){
                                cubit.changePassword(
                                    password: confirmPasswordController.text,
                                );
                                Navigator.pop(context);
                                cubit.getUserData();
                                cubit.getUserData();
                                passwordController.clear();
                                confirmPasswordController.clear();
                              }
                            }
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
