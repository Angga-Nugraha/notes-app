import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/repository/note_repository.dart';
import 'package:notes_app/data/model/notes_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({
    required this.noteRepository,
  }) : super(NoteInitial()) {
    on<FetchNotes>((event, emit) async {
      emit(NoteLoading());
      await Future.delayed(const Duration(milliseconds: 200));
      final result = await noteRepository.getNotes();

      emit(NoteLoaded(result));
    });
    on<AddNotes>((event, emit) async {
      emit(NoteLoading());
      await Future.delayed(const Duration(milliseconds: 200));
      await noteRepository.createNote(event.notes);
      final result = await noteRepository.getNotes();
      emit(NoteAdded('Note Added'));
      emit(NoteLoaded(result));
    });
    on<UpdateNotes>((event, emit) async {
      emit(NoteLoading());
      await Future.delayed(const Duration(milliseconds: 200));
      await noteRepository.updateNote(event.notes);
      final result = await noteRepository.getNotes();
      emit(NoteUpdated('Updated'));
      emit(NoteLoaded(result));
    });

    on<DeleteNote>((event, emit) async {
      await noteRepository.deleteNote(event.id);
      final result = await noteRepository.getNotes();
      emit(NoteDeleted('Deleted'));
      emit(NoteLoaded(result));
    });
  }
}
