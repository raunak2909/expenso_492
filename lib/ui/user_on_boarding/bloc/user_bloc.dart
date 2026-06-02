import 'package:expenso_492/data/local/helpers/db_helper.dart';
import 'package:expenso_492/ui/user_on_boarding/bloc/user_event.dart';
import 'package:expenso_492/ui/user_on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{

  DbHelper dbHelper;
  UserBloc({required this.dbHelper}) : super(UserInitialState()){

    on<UserSignUpEvent>((event, emit) async{

      emit(UserLoadingState());

      int checkValue = await dbHelper.signUpUser(newUser: event.newUser);

      if(checkValue==1){
        emit(UserSuccessState());
      } else if(checkValue==2){
        emit(UserFailureState(errorMsg: "Email already exists!!"));
      } else {
        emit(UserFailureState(errorMsg: "Something went wrong!!"));
      }

    });

    on<UserLoginEvent>((event, emit) async {

      emit(UserLoadingState());

      int checkValue = await dbHelper.loginUser(email: event.email, pass: event.pass);

      if(checkValue==1){
        emit(UserSuccessState());
      } else if(checkValue==2){
        emit(UserFailureState(errorMsg: "Invalid email!!"));
      } else {
        emit(UserFailureState(errorMsg: "Incorrect password!!"));
      }

    });

  }

}