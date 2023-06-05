import 'package:cloud_website/register_screen/register_cubit.dart';
import 'package:cloud_website/register_screen/register_states.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var pinController=TextEditingController();
var nameController=TextEditingController();
var emailController=TextEditingController();
var passController=TextEditingController();
var formKey=GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            Navigator.pop(context);
          }
        },
        builder: (context,state){
          var cubit=RegisterCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: const Text(
                    'Register'
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultFormField(
                            controller: pinController,
                            prefixIcon:const Icon(
                                Icons.person
                            ),
                            obscure: false,
                            keyboardType: TextInputType.number,
                            label: 'PIN',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Enter (2222) to be an admin'
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            prefixIcon:const Icon(
                                Icons.person
                            ),
                            obscure: false,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Name',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'this field mustn\'t be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        defaultFormField(
                            controller: emailController,
                            prefixIcon:const Icon(
                                Icons.email
                            ),
                            obscure: false,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'this field mustn\'t be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            prefixIcon: const Icon(
                                Icons.key
                            ),
                            controller: passController,
                            obscure:cubit.isVisible? false:true,
                            keyboardType: TextInputType.text,
                            label: 'Password',
                            suffixIcon:  IconButton(
                                onPressed: (){
                                  cubit.changeVisibility();
                                },
                                icon: Icon(
                                  cubit.isVisible?Icons.remove_red_eye:Icons.visibility_off_rounded,
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'this field mustn\'t be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder:(context)=> defaultButton(
                              label: 'Register',
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                  );
                                  pinController.clear();
                                  nameController.clear();
                                  emailController.clear();
                                  passController.clear();
                                }
                              }
                          ),
                          fallback: (context)=>const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                            ),
                            TextButton(
                              onPressed: (){
                                nameController.clear();
                                emailController.clear();
                                passController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                  'Login now'
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
