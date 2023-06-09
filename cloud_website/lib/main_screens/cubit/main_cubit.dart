import 'package:cloud_website/login_screen/login_screen.dart';
import 'package:cloud_website/main_screens/cart_screen/cart_screen.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/main_screens/main_screen/main_screen.dart';
import 'package:cloud_website/main_screens/setting_screen.dart';
import 'package:cloud_website/models/product_model.dart';
import 'package:cloud_website/models/search_model.dart';
import 'package:cloud_website/models/user_model.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:cloud_website/shared/components/constants.dart';
import 'package:cloud_website/shared/network/local/cache_helper.dart';
import 'package:cloud_website/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates>{

  MainCubit():super(MainInitialState());

  static MainCubit get(context)=>BlocProvider.of(context);

  UserModel?userModel;

  List<Widget>screens=[
    const MainScreen(),
    const CartScreen(),
    const SettingScreen(),
  ];

  List<String>appBar=[
    'Home',
    'Cart',
    'Settings',
  ];

  List cart=[];

  //sum of cart items
  num sum=0;

  getTotal(){
    sum=0;
    cart.forEach((element){
      sum+=element['price'];
    });
    emit(GetTotalState());
  }

  getUserData(){
    cart=[];
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: 'accounts/get/$uId',
    ).then((value){
      userModel=UserModel.fromJson(value.data);
      value.data['cart'].forEach((element){
        cart.add(element);
      });
      getTotal();
      emit(GetUserDataSuccessState());
    }).catchError((error){
    });
  }

  int currentIndex=0;

  navigation(index){
    currentIndex=index;
    if(index==1){
      getUserData();
      getTotal();
      emit(ChangeNavigationState());
    }
    emit(ChangeNavigationState());
  }

  bool isVisible=false;

  changeVisibility(){
    isVisible=!isVisible;
    emit(ChangeVisibilityState());
  }

  changePassword({
    required password
}){
    DioHelper.putData(
        url: 'accounts/update/${userModel!.email}',
        data: {
          'password':password,
        }
    ).then((value){
      userModel=null;
      userModel=UserModel.fromJson(value.data);
      emit(ChangePasswordSuccessState());
    });
  }

  updateProfile({
    required String email,
    required String name,
}){
    DioHelper.putData(
        url: 'accounts/update/${userModel!.email}',
        data: {
          'name':name,
          'email':email,
        }
    ).then((value){
      userModel=UserModel.fromJson(value.data);
      emit(UpdateUserDataSuccessState());
    });
  }

  List model=[];
  ProductModel ? productModel;
  getProducts(){
    model=[];
    DioHelper.getData(
      url: 'products/get',
    ).then((value){
      value.data.forEach((element){
        model.add(element);
        productModel=ProductModel.fromJson(element);
      });
      getUserData();
      emit(GetProductSuccessState());
    });
  }

  addToCart(index){
    DioHelper.postData(
        url: 'accounts/addtocart',
        data: {
          'name':model[index]['name'],
          'quantity':model[index]['quantity'],
          'image':model[index]['image'],
          'description':model[index]['description'],
          'price':model[index]['price'],
          'id':uId,
        }
    ).then((value){
      getTotal();
      emit(AddedToCartSuccessState());
    });
  }

  removeFromCart(index){
    DioHelper.postData(
        url: 'accounts/removefromcart',
        data: {
          'userId':uId,
          'productId':cart[index]['_id'],
        }
    ).then((value){
      getUserData();
      emit(RemovedFromCartSuccessState());
    });
  }

  addProduct({
    required String name,
    required String quantity,
    required String price,
    required String image,
    required String desc,
}){
    DioHelper.postData(
        url: 'products/add',
        data: {
          'name':name,
          'quantity':quantity,
          'image':image,
          'description':desc,
          'price':price,
        }
    ).then((value){
      getProducts();
      emit(ProductAddedSuccessState());
    });
  }

  SearchModel ? searchModel;
  searchProduct({
    required String name,
}){
    DioHelper.postData(
        url: 'products/search',
      data: {
          'name':name,
      }
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    });
  }

  updateProduct({
required String name,
    required String image,
    required String quantity,
    required String price,
    required String desc,
    required index,
}){
    DioHelper.putData(
        url: 'products/update/${model[index]['name']}',
        data: {
          'name':name,
          'image':image,
          'quantity':quantity,
          'description':desc,
          'price':price,
        }
    ).then((value){
      getProducts();
      emit(UpdateProductSuccessState());
    });
  }

  deleteProduct(index){
    DioHelper.deleteData(
        url: 'products/delete/${model[index]['name']}',
        data: {

        }
    ).then((value){
      getProducts();
      emit(ProductDeletedSuccessState());
    });
  }

  filterProduct({
    required String min,
    required String max,
  }){
    DioHelper.postData(
        url: 'products/filter',
        data: {
          'min':min,
          'max':max,
        }
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    });
  }

  checkoutCart(){
    DioHelper.postData(
        url: 'accounts/checkout',
        data: {
          'email':userModel!.email,
        }
    ).then((value){
      getUserData();
      emit(CheckoutSuccessState());
    });
  }

  deleteAccount({
    required context,
}){
    DioHelper.deleteData(
        url: 'accounts/delete/${userModel!.email}',
        data: {
        }
    ).then((value){
      userModel=null;
      logout(context: context);
      emit(AccountDeletedSuccessState());
    });
  }


  logout({required context}){
    CacheHelper.removeKey(key: 'uId').then((value){
      userModel=null;
      currentIndex=0;
      emit(LogoutSuccessState());
      navigateToFinish(
          context: context,
          screen: const LoginScreen(),
      );
    });
  }

}