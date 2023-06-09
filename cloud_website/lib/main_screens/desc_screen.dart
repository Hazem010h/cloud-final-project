import 'package:cloud_website/main_screens/cubit/main_cubit.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescScreen extends StatelessWidget {
   DescScreen({Key? key,required this.index}) : super(key: key);

   int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title:  Text(
              '${MainCubit.get(context).model[index]['name']}',
            )
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: NetworkImage('${MainCubit.get(context).model[index]['image']}'),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width*0.35,
                    height: MediaQuery.of(context).size.height*0.35,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'name:${MainCubit.get(context).model[index]['name']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${MainCubit.get(context).model[index]['description']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:Text(
                    'Price:${MainCubit.get(context).model[index]['price']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child:defaultButton(
                    label: 'AddToCart',
                    function: (){
                      MainCubit.get(context).addToCart(index);
                    }
                ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
