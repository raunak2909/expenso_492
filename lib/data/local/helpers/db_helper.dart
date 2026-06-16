import 'dart:io';

import 'package:expenso_492/data/local/models/expense_model.dart';
import 'package:expenso_492/data/local/models/user_model.dart';
import 'package:expenso_492/domain/constants/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  Database? mDB;
  static const String DB_NAME = "expenseDB.db";
  static const String TABLE_USER = "user";
  static const String COLUMN_USER_ID = "u_id";
  static const String COLUMN_USER_NAME = "u_name";
  static const String COLUMN_USER_MOBILE_NO = "u_mob_no";
  static const String COLUMN_USER_EMAIL = "u_email";
  static const String COLUMN_USER_PASS = "u_pass";
  static const String COLUMN_USER_CREATED_AT = "u_created_at";
  static const String COLUMN_USER_BAL = "u_bal";
  static const String COLUMN_USER_BUDGET = "u_budget";

  static const String TABLE_EXPENSE = "expense";
  static const String COLUMN_EXPENSE_ID = "e_id";
  static const String COLUMN_EXPENSE_TITLE = "e_title";
  static const String COLUMN_EXPENSE_REMARK = "e_remark";
  static const String COLUMN_EXPENSE_CAT_ID = "e_cat_id";
  static const String COLUMN_EXPENSE_CREATED_AT = "e_created_at";
  static const String COLUMN_EXPENSE_TYPE = "e_type";

  ///0 -> Debit, 1 -> Credit
  static const String COLUMN_EXPENSE_AMT = "e_amt";

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, DB_NAME);

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          " create table $TABLE_USER ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_MOBILE_NO text, $COLUMN_USER_EMAIL text, $COLUMN_USER_PASS text, $COLUMN_USER_CREATED_AT text, $COLUMN_USER_BAL real, $COLUMN_USER_BUDGET real )",
        );
        db.execute(
          " create table $TABLE_EXPENSE ( $COLUMN_EXPENSE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_REMARK text, $COLUMN_EXPENSE_AMT real, $COLUMN_EXPENSE_CAT_ID integer, $COLUMN_EXPENSE_TYPE integer, $COLUMN_EXPENSE_CREATED_AT text )",
        );
      },
      version: 1,
    );
  }

  ///events
  ///signUp user
  ///1-> user created successfully
  ///2-> user email already exists
  ///3-> cannot create user
  Future<int> signUpUser({required UserModel newUser}) async {
    Database db = await initDB();
    bool isUserExists = await isEmailAlreadyExists(email: newUser.email);
    if (isUserExists) {
      return 2;
    } else {
      int rowsEffected = await db.insert(TABLE_USER, newUser.toMap());
      if (rowsEffected > 0) {
        return 1;
      } else {
        return 3;
      }
    }
  }

  ///check if user exists or not
  Future<bool> isEmailAlreadyExists({required String email}) async {
    Database db = await initDB();
    List<Map<String, dynamic>> result = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ?",
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  ///login user
  ///1-> success
  ///2-> invalid email
  ///3-> incorrect pass
  Future<int> loginUser({required String email, required String pass}) async {
    Database db = await initDB();
    bool isEmailCorrect = await isEmailAlreadyExists(email: email);
    if (isEmailCorrect) {
      List<Map<String, dynamic>> mData = await db.query(
        TABLE_USER,
        where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?",
        whereArgs: [email, pass],
      );

      if (mData.isNotEmpty) {
        int userId = mData[0][COLUMN_USER_ID];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(AppConstants.PREF_USER_ID, userId);
        return 1;

        ///success
      } else {
        return 3;

        ///incorrect pass
      }
    } else {
      return 2;

      ///invalid email
    }
  }

  Future<UserModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.PREF_USER_ID) ?? 0;

    var db = await initDB();
    var mData = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_ID = ?",
      whereArgs: ["$uid"],
    );

    return UserModel.fromMap(mData[0]);
  }

  ///add expense
  Future<bool> addExpense({required ExpenseModel newExp}) async {
    var db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.PREF_USER_ID) ?? 0;
    newExp.uid = uid;

    print("expense: ${newExp.amt}");

    int rowsEffected = await db.insert(TABLE_EXPENSE, newExp.toMap());
    return rowsEffected > 0;
  }

  Future<List<ExpenseModel>> fetchAllExp() async {
    var db = await initDB();
    List<ExpenseModel> allExp = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.PREF_USER_ID) ?? 0;

    List<Map<String, dynamic>> mData = await db.query(
      TABLE_EXPENSE,
      where: "$COLUMN_USER_ID = ?",
      whereArgs: ["$uid"],
    );

    for(Map<String, dynamic> eachData in mData){
      allExp.add(ExpenseModel.fromMap(eachData));
    }

    return allExp;
  }
}
