import 'dart:io';


import 'package:notes_app/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  DbHelper._();

  static final DbHelper getInstance = DbHelper._();
  static final String tableName = 'noteData';
  static final String columnSno = 's_no';
  static final String columnTitle = 'title';
  static final String columnDesc = 'desc';

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDb();

    return myDB!;
  }

  Future<Database> openDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();

    String rootPath = appDirectory.path;

    String dbPath = join(rootPath, "notes.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.rawQuery(
          "create table $tableName ( $columnSno integer primary key autoincrement , $columnTitle text, $columnDesc text)");
    });
  }

  /// Add note
  Future<bool> addNote(NoteModel newNote) async {
    var db = await getDB();

    int rowEffected = await db.insert(tableName, newNote.toMap());
    return rowEffected > 0;
  }
    /// Get All Notes
    Future<List<NoteModel>> getAllNotes() async{
    var db = await getDB();

    List<NoteModel> mNote = [];

    var allNotes = await db.query(tableName);
      for(Map<String, dynamic> eachNote in allNotes){
        NoteModel eachModel =  NoteModel.fromMap(eachNote);
        mNote.add(eachModel);
      }
    return mNote;
    }

    /// Update Note
   Future<bool>updateNote({required NoteModel updateNote , required int sno}) async{
    var db = await getDB();

    int rowsEffected = await db.update(tableName, {
      columnTitle: updateNote.title,
      columnDesc: updateNote.desc
    },where: "$columnSno = $sno");
        return rowsEffected>0;
    }

    /// Delete Note
    Future<bool> deleteNote({required int sno}) async{
    var db = await getDB();
    
    int rowsEffected = await db.delete(tableName, where: "$columnSno = ? ", whereArgs: ['$sno']);
    return rowsEffected>0;
  }
}