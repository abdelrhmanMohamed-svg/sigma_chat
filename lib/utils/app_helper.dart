import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class AppHelper {
   static String extractTextFromPdf(String filePath) {
    //Load an existing PDF document.
    final PdfDocument document = PdfDocument(
      inputBytes: File(filePath).readAsBytesSync(),
    );
    //Extract the text from all the pages.
    String text = PdfTextExtractor(document).extractText();
    //Dispose the document.

    document.dispose();
    return text;
  }
}
