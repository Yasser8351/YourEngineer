import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatelessWidget {
  const PDFScreen({super.key, required this.filePath});
  final filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the downloaded PDF
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
