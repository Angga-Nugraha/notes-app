part of 'pdf_bloc.dart';

@immutable
sealed class PDFState {}

final class PDFInitial extends PDFState {}

final class PDFSucces extends PDFState {}
