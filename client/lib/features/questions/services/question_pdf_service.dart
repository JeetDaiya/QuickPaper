import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import '../../../core/hive/models/question_model.dart';
import 'package:pdf/widgets.dart' as pw;

class NormalPdfService {

    /// Generates the PDF and opens the system print dialog
    Future<Uint8List> generatePdf(PdfPageFormat format, List<Question> questions) async {
        final pdf = pw.Document();

        // Load Font
        final fontData = await rootBundle.load("assets/fonts/Gujarati.ttf");
        final ttf = pw.Font.ttf(fontData);
        final textTheme = pw.ThemeData.withFont(
            base: ttf,
            bold: ttf,
            italic: ttf
        );

        // Add Page
        pdf.addPage(
            pw.MultiPage(
                // Use the format passed by the PdfPreview widget (e.g. A4 or Letter)
                pageFormat: format,
                theme: textTheme,
                margin: const pw.EdgeInsets.all(32),
                build: (pw.Context context) {
                    return [
                        _buildHeader(questions),
                        pw.SizedBox(height: 20),
                        ...questions.asMap().entries.map((entry) {
                            return _buildQuestionItem(entry.key + 1, entry.value);
                        }),
                    ];
                },
            ),
        );

        // Return the raw bytes
        return pdf.save();
    }

    // 1. Header Section
    pw.Widget _buildHeader(List<Question> questions) {
        int totalMarks = questions.fold(0, (sum, item) => sum + item.marks);

        return pw.Column(
            children: [
                pw.Text("Final Exam Question Paper", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                pw.Text("Total Questions: ${questions.length}  |  Total Marks: $totalMarks", style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                pw.Divider(thickness: 1),
            ],
        );
    }

    // 2. Individual Question Builder
    pw.Widget _buildQuestionItem(int index, Question q) {

        // Parse the 'additionalData' safely
        Map<String, dynamic> data = {};
        if (q.additionalData != null) {
            data = q.additionalData is Map ? Map<String, dynamic>.from(q.additionalData!) : {};
        }

        return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 15),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                    // Question Number (Q1.)
                    pw.SizedBox(
                        width: 25,
                        child: pw.Text("$index.", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),

                    // Question Content
                    pw.Expanded(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                                // Main Text
                                pw.Text(q.text, style: const pw.TextStyle(fontSize: 12)),
                                pw.SizedBox(height: 5),

                                // -- CASE A: MCQ Options --
                                if (data['options'] != null && data['options'] is List)
                                    _buildOptionsGrid(data['options']),

                                // -- CASE B: Table Data --
                                if (q.questionType == 'Table data')
                                    _buildTable(data),

                                pw.SizedBox(height: 5),

                                // Marks and Type Badge
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                        pw.Text("[ ${q.marks} Marks ]", style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
                                        pw.SizedBox(width: 10),
                                        pw.Text("[ ${q.questionType} ]", style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
                                    ],
                                ),
                                pw.Divider(color: PdfColors.grey300),
                            ],
                        ),
                    ),
                ],
            ),
        );
    }

    // Helper: Grid for Options ((A) ... (B) ...)
    pw.Widget _buildOptionsGrid(List<dynamic> options) {
        return pw.Wrap(
            spacing: 20,
            runSpacing: 5,
            children: options.map((opt) {
                return pw.Container(
                    width: 200, // Forces 2 columns roughly
                    child: pw.Text(opt.toString(), style: const pw.TextStyle(fontSize: 11)),
                );
            }).toList(),
        );
    }

    // Helper: Render Table
    pw.Widget _buildTable(Map<String, dynamic> data) {
        if (data['headers'] == null || data['rows'] == null) return pw.Container();

        final headers = List<String>.from(data['headers']);
        final rows = List<List<dynamic>>.from(data['rows']);

        return pw.Table.fromTextArray(
            headers: headers,
            data: rows,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 10),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
            cellAlignment: pw.Alignment.center,
            border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey),
        );
    }
}