import 'package:cloud_website/main_screens/desc_screen.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_cubit.dart';
import '../cubit/main_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=MainCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
                condition: cubit.cart.isNotEmpty,
                builder: (context) {
                  return ListView.separated(
                      itemBuilder: (context,index)=>buildGrid(context, index),
                      separatorBuilder: (context,index)=>Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      itemCount: cubit.cart.length
                  );
                },
                fallback: (context) => const Center(
                  child: Text(
                    'There is no Products in cart',
                  ),
                )),
          ),
          bottomNavigationBar: cubit.cart.isNotEmpty?Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total:${cubit.total}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ],
            ),
          ):Container(),
        );
      },
    );
  }
  Widget buildGrid(context,index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image(
                  image: NetworkImage('${MainCubit.get(context).cart[index]['image']}'),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width*0.35,
                  height: MediaQuery.of(context).size.height*0.35,
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
                            '${MainCubit.get(context).cart[index]['name']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                '${MainCubit.get(context).cart[index]['price']}',
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
                                  IconButton(
                                      onPressed: (){
                                        MainCubit.get(context).removeFromCart(index);
                                      },
                                      icon: const Icon(
                                          Icons.delete,
                                        color: Colors.red,
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
    );
  }
}
