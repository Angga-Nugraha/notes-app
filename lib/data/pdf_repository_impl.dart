import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:notes_app/repository/pdf_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFRepositoryImpl implements PDFRepository {
  @override
  Future<void> saveAsPdf(Map<String, dynamic> data) async {
    final dir = await getExternalStorageDirectory();

    final bytes = await createContentPDF(data['content']);

    final file = File('${dir!.absolute.path}/${data['title']}.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }
}

Future<Uint8List> createContentPDF(String data) async {
  final doc = pw.Document(pageMode: PdfPageMode.outlines);
  final regularFont = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
  final boldFont = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');

  doc.addPage(pw.MultiPage(
    pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        theme: pw.ThemeData.withFont(
          base: pw.Font.ttf(regularFont),
          bold: pw.Font.ttf(boldFont),
        )),
    build: (context) {
      return [
        pw.Paragraph(
          text: data,
          style: const pw.TextStyle(fontSize: 12),
          textAlign: pw.TextAlign.justify,
        )
      ];
    },
  ));

  return await doc.save();
}
