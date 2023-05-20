import 'package:cloud_website/login_screen/cubit/login_states.dart';
import 'package:cloud_website/models/user_model.dart';
import 'package:cloud_website/shared/components/constants.dart';
import 'package:cloud_website/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isVisible=false;

  changeVisibility(){
    isVisible=!isVisible;
    emit(ChangeVisibilityState());
  }

  UserModel? userModel;

  userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());

    DioHelper.postData(
        url: 'accounts/signin',
        data: {
          'email':email,
          'password':password,
        }
    ).then((value){
      if(value.data['message']=="login success"){
        userModel=UserModel.fromJson(value.data);
        uId=userModel!.user!.sId;
        emit(LoginSuccessState());
      }else{
        emit(LoginErrorState());
      }
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}