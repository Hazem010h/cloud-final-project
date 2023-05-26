import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/main_screens/filter_screen/filter_screen.dart';
import 'package:cloud_website/main_screens/search_screen/search_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

var nameController = TextEditingController();
var quantityController = TextEditingController();
var priceController = TextEditingController();
var descController = TextEditingController();

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context: context, screen: const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    navigateTo(context: context, screen: const FilterScreen());
                  },
                  icon: const Icon(
                    Icons.filter_list_outlined,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: cubit.currentIndex == 1 &&
                    cubit.cart.isNotEmpty
                ? FloatingActionButton(
                    onPressed: () {
                      cubit.checkoutCart();
                    },
                    tooltip: 'Checkout',
                    child: const Icon(Icons.shopping_cart_checkout_rounded),
                  )
                : cubit.currentIndex == 0 && cubit.userModel!.admin == true
                    ? FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Add Task'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        defaultFormField(
                                            controller: nameController,
                                            obscure: false,
                                            keyboardType: TextInputType.number,
                                            label: 'Name',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'You Should add any thing';
                                              }
                                              return null;
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        defaultFormField(
                                            controller: quantityController,
                                            obscure: false,
                                            keyboardType: TextInputType.number,
                                            label: 'quantity',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'You Should add any thing';
                                              }
                                              return null;
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        defaultFormField(
                                            controller: priceController,
                                            obscure: false,
                                            keyboardType: TextInputType.number,
                                            label: 'price',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'You Should add any thing';
                                              }
                                              return null;
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        defaultFormField(
                                            controller: descController,
                                            obscure: false,
                                            keyboardType: TextInputType.text,
                                            label: 'description',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'You Should add any thing';
                                              }
                                              return null;
                                            }),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          cubit.addProduct(
                                            name: nameController.text,
                                            quantity: quantityController.text,
                                            price: priceController.text,
                                            desc: descController.text,
                                          );
                                          nameController.clear();
                                          quantityController.clear();
                                          priceController.clear();
                                          descController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Add')),
                                    TextButton(
                                        onPressed: () {
                                          nameController.clear();
                                          quantityController.clear();
                                          priceController.clear();
                                          descController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                        )),
                                  ],
                                );
                              });
                        },
                        tooltip: 'Add',
                        child: const Icon(Icons.add),
                      )
                    : Container(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.navigation(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Main',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting',
                ),
              ],
            ),
          ),
          fallback: (context) => const Scaffold(),
        );
      },
    );
  }
}
