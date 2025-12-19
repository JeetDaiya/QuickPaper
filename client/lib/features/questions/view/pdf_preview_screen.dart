import 'dart:io';
import 'dart:typed_data';
import 'package:client/features/history/providers/saved_paper_provider.dart';
import 'package:client/features/subject/domain/subject.dart';
import 'package:client/features/subject/providers/paper_flow_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/hive/models/paper_model.dart';
import '../../history/repository/saved_papers_repository.dart';
import '../../home/viewmodel/stat_viewmodel.dart';
import '../providers/selected_questions_provider.dart';


class PdfPreviewScreen extends ConsumerWidget {
  final Future<Uint8List> pdfData;
  final String title;
  final Subject subject;

  const PdfPreviewScreen({
    super.key,
    required this.pdfData,
    required this.title,
    required this.subject
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        // 'build' is required by the library, but since we already have the bytes,
        // we just return them.
        build: (format) => pdfData,

        // Customization options
        allowPrinting: true,
        allowSharing: true,
        canChangeOrientation: false,
        canDebug: false,

        pdfFileName: title + DateFormat.yMMMMd().format(DateTime.now()),
        actions: [
          PdfPreviewAction(
            icon: const Icon(Icons.save),
            onPressed: (context, layout, format) async {
              await _saveToHive(context, ref, subject, pdfData, title);
            },
          ),
        ],

        // This makes it look like a real document on the screen
        scrollViewDecoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}




Future<void> _saveToHive(BuildContext context, WidgetRef ref, Subject subject, Future<Uint8List> futurePdfData, String title) async {
  final selectedQuestion = ref.watch(selectedQuestionsProvider);


  try {
    // 1. Create the Hive Object
    final pdfData = await futurePdfData;
    final path = await savePdf(filename: title + DateFormat.yMMMMd().format(DateTime.now()), data: pdfData);

    final newPaper = Paper(
      dateOfCreation: DateFormat.yMMMMd().format(DateTime.now()),
      subject: subject.label,
      questionIds: selectedQuestion.map((question) => question.id).toList(),
      filePath: path
    );

    // 2. Access your Provider/Repository to save it
    // (Adjust this line to match your actual provider name)
    ref.read(savedPapersRepositoryProvider).addPaper(newPaper);
    ref.invalidate(getPapersProvider);
    ref.invalidate(statViewmodelProvider);
    // 3. Show Success
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paper saved to History successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving paper: $e"), backgroundColor: Colors.red),
      );
    }
  }
}


Future<String> savePdf({required String filename, required Uint8List data}) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$filename.pdf';
  final file = File(filePath);
  await file.writeAsBytes(data);
  return filePath;
}
