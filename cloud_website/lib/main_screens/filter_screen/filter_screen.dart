import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../search_desc_screen/search_desc.dart';

var minController=TextEditingController();
var maxController=TextEditingController();

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  minController.clear();
                  maxController.clear();
                  MainCubit.get(context).searchModel=null;
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                )
            ),
            centerTitle: false,
            title: const Text(
                'Filter Screen'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: defaultFormField(
                          controller: minController,
                          obscure: false,
                          keyboardType: TextInputType.number,
                          label: 'Enter Min value',

                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: defaultFormField(
                          controller: maxController,
                          obscure: false,
                          keyboardType: TextInputType.number,
                          label: 'Enter max value',
                          onSubmit: (value){
                            if(minController.text.isEmpty){
                              minController.text=0.toString();
                              MainCubit.get(context).filterProduct(min:minController.text,max:maxController.text);
                            }else if(minController.text.isNotEmpty){
                              MainCubit.get(context).filterProduct(min:minController.text,max:maxController.text);
                            }
                          }
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                          if(minController.text.isEmpty){
                            minController.text=0.toString();
                            MainCubit.get(context).filterProduct(min:minController.text,max:maxController.text);
                          }else if(minController.text.isNotEmpty){
                            MainCubit.get(context).filterProduct(min:minController.text,max:maxController.text);
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                        )
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                minController.text.isNotEmpty||maxController.text.isNotEmpty? ConditionalBuilder(
                  condition: state is! SearchLoadingState,
                  builder: (context)=>Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)=>InkWell(
                        onTap: (){
                          navigateTo(context:context,screen: SearchDescScreen(index: index,));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage('${MainCubit.get(context).searchModel!.products![index].image}'),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    )
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${MainCubit.get(context).searchModel!.products![index].name}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${MainCubit.get(context).searchModel!.products![index].price}',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      if(MainCubit.get(context).userModel!.admin!)
                                                        IconButton(
                                                            onPressed: (){
                                                              MainCubit.get(context).deleteProduct(index);
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            )
                                                        ),
                                                      IconButton(
                                                          onPressed: (){
                                                            MainCubit.get(context).addToCart(index);
                                                          },
                                                          icon: const Icon(
                                                              Icons.add_shopping_cart_outlined
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context,index)=>Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 1,
                      ),
                      itemCount: MainCubit.get(context).searchModel!.products!.length,
                    ),
                  ),
                  fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                ):Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
