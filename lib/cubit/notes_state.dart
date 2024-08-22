
import 'package:notes_app/data/models/note_model.dart';
abstract class NotesState{}

class NotesInitialState extends NotesState{}

class NotesLoadingState extends NotesState{}

class NotesLoadedState extends NotesState{
 List<NoteModel> notesList;

  NotesLoadedState({required this.notesList});

}

class NotesErrorState extends NotesState{
 String msg;

 NotesErrorState({required this.msg});
}