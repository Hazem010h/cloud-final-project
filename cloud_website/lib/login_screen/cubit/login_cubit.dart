import 'package:cloud_website/login_screen/cubit/login_states.dart';
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
      emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}