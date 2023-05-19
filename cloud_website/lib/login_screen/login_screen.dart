import 'package:cloud_website/register_screen/register_screen.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

var emailController=TextEditingController();
var passController=TextEditingController();
var formKey=GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=LoginCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
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
                        defaultButton(
                            label: 'Login',
                            function: (){
                              if(formKey.currentState!.validate()){

                              }
                            }
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
