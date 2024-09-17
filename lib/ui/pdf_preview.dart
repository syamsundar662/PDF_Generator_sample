import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String filePath;

  const PdfPreviewScreen({Key? key, required this.filePath}) : super(key: key);

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
        onRender: (pages) => print('Rendered $pages pages.'),
        onError: (error) => print(error.toString()),
        onPageError: (page, error) => print('$page: $error'),
      ),
    );
  }
}
