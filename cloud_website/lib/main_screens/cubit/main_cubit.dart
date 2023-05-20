import 'package:cloud_website/login_screen/login_screen.dart';
import 'package:cloud_website/main_screens/cubit/main_states.dart';
import 'package:cloud_website/models/user_model.dart';
import 'package:cloud_website/shared/components/components.dart';
import 'package:cloud_website/shared/components/constants.dart';
import 'package:cloud_website/shared/network/local/cache_helper.dart';
import 'package:cloud_website/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates>{

  MainCubit():super(MainInitialState());

  static MainCubit get(context)=>BlocProvider.of(context);

  UserModel?userModel;

  getUserData(){
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: 'accounts/get/$uId',
    ).then((value){
      userModel=UserModel.fromJson(value.data);
      emit(GetUserDataSuccessState());
    }).catchError((error){
    });
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

  logout({required context}){
    CacheHelper.removeKey(key: 'uId').then((value){
      emit(LogoutSuccessState());
      navigateToFinish(
          context: context,
          screen: const LoginScreen(),
      );
    });
  }

}