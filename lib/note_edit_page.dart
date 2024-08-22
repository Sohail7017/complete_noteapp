import 'package:flutter/material.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/database/db_helper.dart';

import 'package:provider/provider.dart';

class NoteEditPage extends StatefulWidget{
  bool isUpdate;
  NoteModel? updateNote;
  NoteEditPage({this.isUpdate = false , this.updateNote});
  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  DbHelper? mainDb;
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(widget.isUpdate){
      titleController.text = widget.updateNote!.title;
      descController.text = widget.updateNote!.desc;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text(widget.isUpdate ? 'Update Note' :'Add Note',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
            height: 70,
        ),
            Text('Title',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(width: 2,color: Colors.black),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter your title....',
                  hintStyle: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Description',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                maxLines: 4,
                controller: descController,
                decoration: InputDecoration(
                    hintText: 'Enter your description.....',
                    hintStyle: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 110,
                    child: ElevatedButton(onPressed: (){
                      addNoteInDB();
                       titleController.clear();
                      descController.clear();
                      Navigator.pop(context);
                    }, child: Text(widget.isUpdate ? 'Update' : 'Add',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),)),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),)


              ],
            )
          ],
        ),
      ),
    );
  }
  void addNoteInDB(){
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();

    widget.isUpdate ?
        context.read<NoteCubit>().updateNote(updateNote: NoteModel(title: mTitle, desc: mDesc), sNo: widget.updateNote!.sNo!) /*updateNote(updateNote: NoteModel( title: mTitle, desc: mDesc),sno: widget.updateNote!.sNo!)*/
        : context.read<NoteCubit>().addNote(freshNote: NoteModel(title: mTitle, desc: mDesc));

  }
}