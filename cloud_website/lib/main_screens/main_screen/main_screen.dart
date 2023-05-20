import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ConditionalBuilder(
          condition: MainCubit.get(context).productModel != null,
          builder: (context) {
            return homeBuilder(context);
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          )),
    );
  }


  Widget homeBuilder(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                MainCubit.get(context).model.length,
                    (index) => buildGrid(context,index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrid(context,index) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        color: Colors.white,
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
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){

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
    );
  }
}
