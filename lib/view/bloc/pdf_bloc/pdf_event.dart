part of 'pdf_bloc.dart';

sealed class PDFEvent {}

final class SaveAsPdf extends PDFEvent {
  Map<String, dynamic> data;

  SaveAsPdf(this.data);
}
