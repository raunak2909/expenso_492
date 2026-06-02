import 'package:expenso_492/data/local/models/user_model.dart';

abstract class UserEvent {}

class UserSignUpEvent extends UserEvent {
  UserModel newUser;

  UserSignUpEvent({required this.newUser});
}

class UserLoginEvent extends UserEvent {
  String email, pass;

  UserLoginEvent({required this.email, required this.pass});
}
