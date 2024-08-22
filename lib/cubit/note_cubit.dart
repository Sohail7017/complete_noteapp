import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/notes_state.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/database/db_helper.dart';

class NoteCubit extends Cubit <NotesState>{
  DbHelper db;
  NoteCubit({required this.db}) : super(NotesInitialState());

  ///Add Note
  void addNote({required NoteModel freshNote}) async{
    emit(NotesLoadingState());

    bool isAdded = await db.addNote(freshNote);

    if(isAdded){
      var notesData = await db.getAllNotes();
      emit(NotesLoadedState(notesList: notesData));
    }else{
      emit(NotesErrorState(msg: 'Notes Add Failed'));
    }
  }
/// Fetch Note
  void fetchNotes() async{
    emit(NotesLoadingState());
    List<NoteModel> notesData = await db.getAllNotes();
    emit(NotesLoadedState(notesList: notesData));
  }

  /// Update Note

void updateNote({required NoteModel updateNote, required int sNo}) async{
    emit(NotesLoadingState());

    bool isUpdateNote = await db.updateNote(updateNote: updateNote, sno: sNo);

    if(isUpdateNote){
      List<NoteModel> notesData = await db.getAllNotes();
      emit(NotesLoadedState(notesList: notesData));
    }else{
      emit(NotesErrorState(msg: 'Notes Update Failed'));
    }
}

/// Delete Note
void deleteNote({required int sNo}) async{
    emit(NotesLoadingState());
    bool isDelete = await db.deleteNote(sno: sNo);

    if(isDelete){
      List<NoteModel> notesData = await db.getAllNotes();
      emit(NotesLoadedState(notesList: notesData));
    }else{
      emit(NotesErrorState(msg: 'Note Delete Failed'));
    }

}

}