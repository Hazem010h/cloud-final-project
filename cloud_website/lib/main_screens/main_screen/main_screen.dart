import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        print(MainCubit.get(context).model[index]['_id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${MainCubit.get(context).model[index]['_id']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            '${MainCubit.get(context).model[index]['price']}',
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
        ),
      ),
    );
  }
}
