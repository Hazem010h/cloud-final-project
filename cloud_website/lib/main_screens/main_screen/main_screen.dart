import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/main_screens/desc_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

var nameController=TextEditingController();
var imageController=TextEditingController();
var quantityController=TextEditingController();
var priceController=TextEditingController();
var descController=TextEditingController();


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=MainCubit.get(context);
          return cubit.model.isNotEmpty? Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
                condition: MainCubit.get(context).productModel!=null,
                builder: (context) {
                  return ListView.separated(
                      itemBuilder: (context,index)=>buildGrid(context, index),
                      separatorBuilder: (context,index)=>Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      itemCount: cubit.model.length
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                )),
          ):Container();
        },
    );
  }



  Widget buildGrid(context,index) {
    return InkWell(
      onTap: (){
        navigateTo(context: context,screen:  DescScreen(index:index));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image(
                      image: NetworkImage('${MainCubit.get(context).model[index]['image']}'),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width*0.35,
                      height: MediaQuery.of(context).size.height*0.35,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${MainCubit.get(context).model[index]['name']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${MainCubit.get(context).model[index]['price']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                                if(MainCubit.get(context).userModel!.admin!)
                                  IconButton(
                                      onPressed: (){
                                        nameController.text='${MainCubit.get(context).model[index]['name']}';
                                        imageController.text='${MainCubit.get(context).model[index]['image']}';
                                        quantityController.text='${MainCubit.get(context).model[index]['quantity']}';
                                        priceController.text='${MainCubit.get(context).model[index]['price']}';
                                        descController.text='${MainCubit.get(context).model[index]['description']}';
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Update Product'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      defaultFormField(
                                                          controller: nameController,
                                                          obscure: false,
                                                          keyboardType:TextInputType.text,
                                                          label: 'Name',
                                                          validator: (value){
                                                            if(value!.isEmpty){
                                                              return 'You Should add task';
                                                            }
                                                            return null;

                                                          }
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      defaultFormField(
                                                          controller: imageController,
                                                          obscure: false,
                                                          keyboardType:TextInputType.text,
                                                          label: 'Image',
                                                          validator: (value){
                                                            if(value!.isEmpty){
                                                              return 'You Should add task';
                                                            }
                                                            return null;

                                                          }
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      defaultFormField(
                                                          controller: quantityController,
                                                          obscure: false,
                                                          keyboardType:TextInputType.number,
                                                          label: 'Quantity',
                                                          validator: (value){
                                                            if(value!.isEmpty){
                                                              return 'You Should add task';
                                                            }
                                                            return null;

                                                          }
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      defaultFormField(
                                                          controller: priceController,
                                                          obscure: false,
                                                          keyboardType:TextInputType.number,
                                                          label: 'Price',
                                                          validator: (value){
                                                            if(value!.isEmpty){
                                                              return 'You Should add task';
                                                            }
                                                            return null;

                                                          }
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      defaultFormField(
                                                          controller: descController,
                                                          obscure: false,
                                                          keyboardType:TextInputType.text,
                                                          label: 'Description',
                                                          validator: (value){
                                                            if(value!.isEmpty){
                                                              return 'You Should add task';
                                                            }
                                                            return null;

                                                          }
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: (){
                                                        if(nameController.text.isNotEmpty&&imageController.text.isNotEmpty&&quantityController.text.isNotEmpty&&priceController.text.isNotEmpty&&descController.text.isNotEmpty){
                                                          MainCubit.get(context).updateProduct(
                                                              name: nameController.text,
                                                              image: imageController.text,
                                                              quantity: quantityController.text,
                                                              price: priceController.text,
                                                              desc: descController.text,
                                                              index: index
                                                          );
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Update'
                                                      )
                                                  ),
                                                  TextButton(
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                      )
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
