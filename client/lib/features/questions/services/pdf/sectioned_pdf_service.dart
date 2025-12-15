import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/hive/models/question_model.dart';
import '../../domain/question_type_instruction.dart';
import '../../domain/section_rules.dart';
import 'pdf_widgets.dart';

class SectionedPdfService {
  Future<Uint8List> generate(
      PdfPageFormat format,
      List<Question> questions,
      ) async {
    final pdf = pw.Document();

    final fontData =
    await rootBundle.load('assets/fonts/Gujarati.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        theme: pw.ThemeData.withFont(base: ttf),
        margin: const pw.EdgeInsets.all(32),
        build: (_) => _buildPaper(questions),
      ),
    );

    return pdf.save();
  }

  List<pw.Widget> _buildPaper(List<Question> questions) {
    final widgets = <pw.Widget>[];
    int qNo = 1;

    widgets.add(_header(questions));
    widgets.add(pw.SizedBox(height: 20));

    for (final section in sections) {
      final sectionQuestions =
      questions.where(section.matcher).toList();

      if (sectionQuestions.isEmpty) continue;

      widgets.add(sectionTitle(section.title));
      widgets.add(sectionInstructionWidget(section.sectionInstruction));
      widgets.add(pw.SizedBox(height: 8));

      // 🔥 GROUP BY QUESTION TYPE INSIDE SECTION
      final Map<String, List<Question>> byType = {};

      for (final q in sectionQuestions) {
        byType.putIfAbsent(q.questionType, () => []).add(q);
      }

      for (final entry in byType.entries) {
        final type = entry.key;
        final qs = entry.value;

        // Question-type instruction (ONCE)
        final instruction = questionTypeInstructions[type];
        if (instruction != null) {
          widgets.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 6),
              child: pw.Text(
                instruction,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          );
        }

        // Questions
        for (final q in qs) {
          widgets.add(_question(qNo++, q));
        }

        widgets.add(pw.SizedBox(height: 10));
      }
    }

    return widgets;
  }

  pw.Widget _header(List<Question> questions) {
    final totalMarks =
    questions.fold(0, (s, q) => s + q.marks);

    return pw.Column(
      children: [
        pw.Text(
          'Final Examination',
          style: pw.TextStyle(
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'Total Questions: ${questions.length}   |   Total Marks: $totalMarks',
          style: pw.TextStyle(fontSize: 12),
        ),
        pw.Divider(),
      ],
    );
  }

  pw.Widget _question(int index, Question q) {
    final data =
    q.additionalData is Map ? Map<String, dynamic>.from(q.additionalData!) : {};

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('$index. ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Expanded(
                child: pw.Text(q.text, style: const pw.TextStyle(fontSize: 12)),
              ),
            ],
          ),

          if (data['options'] is List)
            _options(data['options']),


          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              '(${q.marks} marks)',
              style: pw.TextStyle(fontSize: 9),
            ),
          ),

        ],
      ),
    );
  }

  pw.Widget _options(List options) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 20, top: 6),
      child: pw.Wrap(
        spacing: 30,
        runSpacing: 6,
        children: options.map((o) {
          return pw.SizedBox(
            width: 220,
            child: pw.Text(o.toString(),
                style: const pw.TextStyle(fontSize: 11)),
          );
        }).toList(),
      ),
    );
  }
}
