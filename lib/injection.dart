import 'package:get_it/get_it.dart';
import 'package:notes_app/data/pdf_repository_impl.dart';
import 'package:notes_app/data/repository_impl.dart';
import 'package:notes_app/repository/note_repository.dart';
import 'package:notes_app/repository/pdf_repository.dart';
import 'package:notes_app/view/bloc/notes_bloc/note_bloc.dart';
import 'package:notes_app/view/bloc/pdf_bloc/pdf_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => NoteBloc(noteRepository: locator()));
  locator.registerFactory(() => PDFBloc(pdfRepository: locator()));
  locator.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl());
  locator.registerLazySingleton<PDFRepository>(() => PDFRepositoryImpl());
}
