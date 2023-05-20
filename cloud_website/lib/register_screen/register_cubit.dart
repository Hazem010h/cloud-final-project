import 'package:cloud_website/register_screen/register_states.dart';
import 'package:cloud_website/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isVisible=false;

  changeVisibility(){
    isVisible=!isVisible;
    emit(ChangeVisibilityState());
  }
  userRegister({
    required String name,
    required String email,
    required String password,
}){
    DioHelper.postData(
        url: 'accounts/signup',
        data: {
          'name':name,
          'email':email,
          'password':password,
        }
        ).then((value){
          if(value.data['message']=="sign up success"){
            emit(RegisterSuccessState());
          }else{
            emit(RegisterErrorState());
          }
    }).catchError((error){
      emit(RegisterErrorState());
    });
  }
}