import 'package:cloud_website/main_screens/layout/layout.dart';
import 'package:cloud_website/register_screen/register_screen.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:cloud_website/shared/components/constants.dart';
import 'package:cloud_website/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

var loginEmail=TextEditingController();
var loginPass=TextEditingController();
var formKey=GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            CacheHelper.saveData(
              key: 'uId',
              value: uId,
            ).then((value){
              navigateToFinish(
                context: context,
                screen: const LayoutScreen(),
              );
            });

          }
        },
        builder: (context,state){
          var cubit=LoginCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: const Text(
                    'Login'
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultFormField(
                            controller: loginEmail,
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
                            controller: loginPass,
                            obscure:cubit.isVisible? false:true,
                            keyboardType: TextInputType.text,
                            label: 'Password',
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(
                                  email: loginEmail.text,
                                  password: loginPass.text,
                                );
                                loginPass.clear();
                                loginEmail.clear();
                              }
                            },
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
                          condition: state is! LoginLoadingState,
                          builder: (context)=>defaultButton(
                              label: 'Login',
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                    email: loginEmail.text,
                                    password: loginPass.text,
                                  );
                                  loginPass.clear();
                                  loginEmail.clear();
                                }
                              }
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: (){
                                emailController.clear();
                                passController.clear();
                                navigateTo(
                                    context: context,
                                    screen: const RegisterScreen(),
                                );
                              },
                              child: const Text(
                                  'Register now'
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
