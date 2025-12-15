import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

pw.Widget sectionTitle(String text) {
  return pw.Text(
    text,
    style: pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
    ),
  );
}

pw.Widget sectionInstructionWidget(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 4, bottom: 8),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 11,
        fontStyle: pw.FontStyle.italic,
      ),
    ),
  );
}

pw.Widget answerLines(int lines) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(left: 20, top: 6),
    child: pw.Column(
      children: List.generate(
        lines,
            (_) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 6),
          height: 12,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.grey),
            ),
          ),
        ),
      ),
    ),
  );
}
