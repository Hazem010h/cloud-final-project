import 'package:cloud_website/register_screen/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isVisible=false;

  changeVisibility(){
    isVisible=!isVisible;
    emit(ChangeVisibilityState());
  }
}