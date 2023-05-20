import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_states.dart';

var nameController=TextEditingController();
var emailController=TextEditingController();
var formKey=GlobalKey<FormState>();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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
                  nameController.clear();
                  emailController.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                    Icons.arrow_back_ios
                ),
              ),
              centerTitle: true,
              title: const Text(
                'Change name',
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
                          controller: nameController,
                          obscure:false,
                          keyboardType: TextInputType.text,
                          label: '${cubit.userModel!.name}',
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
                          controller: emailController,
                          obscure:false,
                          keyboardType: TextInputType.text,
                          label: '${cubit.userModel!.email}',
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
                      defaultButton(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: 30,
                          label: 'Edit profile',
                          function: (){
                            if(formKey.currentState!.validate()){
                                Navigator.pop(context);
                                cubit.getUserData();
                                cubit.getUserData();
                                nameController.clear();
                                emailController.clear();

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
