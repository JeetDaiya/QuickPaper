import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  // We pass the PDF bytes directly to this screen
  final Future<Uint8List> pdfData;
  final String title;

  const PdfPreviewScreen({
    super.key,
    required this.pdfData,
    this.title = "Question Paper Preview"
  });

  @override
  Widget build(BuildContext context) {
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

        // This makes it look like a real document on the screen
        scrollViewDecoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}