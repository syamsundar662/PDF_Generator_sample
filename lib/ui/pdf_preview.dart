import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String filePath;

  const PdfPreviewScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PDFView(
        filePath: filePath,
        autoSpacing: false,
        swipeHorizontal: true,
        pageSnap: true,
        pageFling: true,
        onRender: (pages) => log('Rendered $pages pages.'),
        onError: (error) => log(error.toString()),
        onPageError: (page, error) => log('$page: $error'),
      ),
    );
  }
}
