

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/database/db_helper.dart';
import 'package:notes_app/note_edit_page.dart';
import 'package:notes_app/note_home_page.dart';


void main (){
  runApp(BlocProvider(create: (context) => NoteCubit(db: DbHelper.getInstance),

    /*ChangeNotifierProvider(create: (_) => NoteDbProvider(mainDB: DbHelper.getInstance*//*),*/
  child: NotesApp(),
  ));
}
 class NotesApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
 }