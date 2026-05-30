import 'package:expenso_492/data/local/helpers/db_helper.dart';

class UserModel {
  int? id;
  int created_at;
  String name, email, pass, mobNo;
  num bal, budget;

  UserModel({
    this.id,
    required this.name,
    required this.mobNo,
    required this.email,
    required this.pass,
    required this.created_at,
    required this.bal,
    required this.budget
  });

  ///fromMap
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        id: map[DbHelper.COLUMN_USER_ID],
        name: map[DbHelper.COLUMN_USER_NAME],
        mobNo: map[DbHelper.COLUMN_USER_MOBILE_NO],
        email: map[DbHelper.COLUMN_USER_EMAIL],
        pass: map[DbHelper.COLUMN_USER_PASS],
        created_at: int.parse(map[DbHelper.COLUMN_USER_CREATED_AT]),
        bal: map[DbHelper.COLUMN_USER_BAL],
        budget: map[DbHelper.COLUMN_USER_BUDGET]);
  }

  ///toMap
  Map<String, dynamic> toMap(){
    return {
      DbHelper.COLUMN_USER_EMAIL : email,
      DbHelper.COLUMN_USER_MOBILE_NO : mobNo,
      DbHelper.COLUMN_USER_BAL : bal,
      DbHelper.COLUMN_USER_BUDGET : budget,
      DbHelper.COLUMN_USER_CREATED_AT : created_at.toString(),
      DbHelper.COLUMN_USER_NAME : name,
      DbHelper.COLUMN_USER_PASS : pass,
    };
  }

}