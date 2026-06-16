import '../helpers/db_helper.dart';

class ExpenseModel {
  int? eid;
  int? uid;
  String title, remark;
  num amt;
  int created_at;
  int cat_id;
  int type;

  ExpenseModel({
    this.eid,
    this.uid,
    required this.title,
    required this.remark,
    required this.amt,
    required this.created_at,
    required this.cat_id,
    required this.type,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map){
    return ExpenseModel(
      eid: map[DbHelper.COLUMN_EXPENSE_ID],
      uid: map[DbHelper.COLUMN_USER_ID],
      title: map[DbHelper.COLUMN_EXPENSE_TITLE],
      remark: map[DbHelper.COLUMN_EXPENSE_REMARK],
      amt: map[DbHelper.COLUMN_EXPENSE_AMT],
      created_at: int.parse(map[DbHelper.COLUMN_EXPENSE_CREATED_AT]),
      cat_id: map[DbHelper.COLUMN_EXPENSE_CAT_ID],
      type: map[DbHelper.COLUMN_EXPENSE_TYPE],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      DbHelper.COLUMN_USER_ID : uid,
      DbHelper.COLUMN_EXPENSE_TITLE : title,
      DbHelper.COLUMN_EXPENSE_REMARK : remark,
      DbHelper.COLUMN_EXPENSE_AMT : amt,
      DbHelper.COLUMN_EXPENSE_CREATED_AT : created_at.toString(),
      DbHelper.COLUMN_EXPENSE_CAT_ID : cat_id,
      DbHelper.COLUMN_EXPENSE_TYPE : type,
    };
  }
}
