part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteAdded extends NoteState {
  final String result;

  NoteAdded(this.result);
}

final class NoteLoaded extends NoteState {
  final List<NoteModel> result;

  NoteLoaded(this.result);
}

final class NoteUpdated extends NoteState {
  final String result;

  NoteUpdated(this.result);
}

final class NoteDeleted extends NoteState {
  final String result;

  NoteDeleted(this.result);
}
