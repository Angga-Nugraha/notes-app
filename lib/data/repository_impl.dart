import 'package:hive/hive.dart';
import 'package:notes_app/data/model/notes_model.dart';
import 'package:notes_app/repository/note_repository.dart';

const noteBox = 'notes-box';

class NoteRepositoryImpl implements NoteRepository {
  @override
  Future<void> createNote(NoteModel note) async {
    final box = await Hive.openBox<NoteModel>(noteBox);
    var newNote = note;

    final id = await box.add(newNote);

    newNote.id = id;

    newNote.save();
  }

  @override
  Future<void> deleteNote(int id) async {
    final box = await Hive.openBox<NoteModel>(noteBox);
    await box.delete(id);
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    final box = await Hive.openBox<NoteModel>(noteBox);
    return box.values.toList();
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final box = await Hive.openBox<NoteModel>(noteBox);
    await box.put(note.id, note);
  }
}
