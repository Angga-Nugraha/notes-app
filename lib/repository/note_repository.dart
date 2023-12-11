import 'package:notes_app/data/model/notes_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getNotes();
  Future<void> createNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(int id);
}



// import 'package:notes_app/data/database_helper.dart';
// import 'package:notes_app/data/model/notes_model.dart';

// import '../utils/exception.dart';

// class NoteRepository {
//   final DataBaseHelper dataBaseHelper = DataBaseHelper();

//   Future<String> createNote(NoteModel note) async {
//     try {
//       await dataBaseHelper.create(note);

//       return 'Note Added';
//     } on DBException catch (e) {
//       throw DBException(e.toString());
//     }
//   }

//   Future<String> updateNote(NoteModel note) async {
//     try {
//       await dataBaseHelper.update(note);

//       return 'Note Updated';
//     } on DBException catch (e) {
//       throw DBException(e.toString());
//     }
//   }

//   Future<String> deleteNote(int id) async {
//     try {
//       await dataBaseHelper.delete(id);

//       return 'Note Deleted';
//     } on DBException catch (e) {
//       throw DBException(e.toString());
//     }
//   }

//   Future<List<NoteModel>> getData() async {
//     try {
//       final result = await dataBaseHelper.getAllNotes();
//       var data = result.map((e) => NoteModel.fromMap(e)).toList();

//       return data;
//     } catch (e) {
//       throw DBException(e.toString());
//     }
//   }

//   Future<NoteModel?> getNoteById(int id) async {
//     final result = await dataBaseHelper.getNoteById(id);
//     if (result != null) {
//       return NoteModel.fromMap(result);
//     } else {
//       return null;
//     }
//   }
// }
