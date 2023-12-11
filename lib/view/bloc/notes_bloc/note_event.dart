part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

final class FetchNotes extends NoteEvent {}

final class AddNotes extends NoteEvent {
  final NoteModel notes;

  AddNotes(this.notes);
}

final class UpdateNotes extends NoteEvent {
  final NoteModel notes;

  UpdateNotes(this.notes);
}

final class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote(this.id);
}
