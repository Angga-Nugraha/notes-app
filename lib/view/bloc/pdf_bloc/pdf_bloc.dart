import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/repository/pdf_repository.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PDFBloc extends Bloc<PDFEvent, PDFState> {
  PDFRepository pdfRepository;

  PDFBloc({required this.pdfRepository}) : super(PDFInitial()) {
    on<SaveAsPdf>((event, emit) async {
      await pdfRepository.saveAsPdf(event.data);
      emit(PDFSucces());
    });
  }
}
