
import 'package:notes_app/database/db_helper.dart';

class NoteModel{
  int? sNo;
  String title;
  String desc;

  NoteModel({this.sNo,required this.title, required this.desc});

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
        sNo : map[DbHelper.columnSno],
        title : map[DbHelper.columnTitle],
        desc: map[DbHelper.columnDesc]);
  }

  Map<String,dynamic> toMap()  {
    return {
      DbHelper.columnTitle: title,
      DbHelper.columnDesc: desc
    };
  }
}

