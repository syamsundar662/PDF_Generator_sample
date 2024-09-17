import 'package:firebase_realtime/ui/pdf_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_realtime/services/pdf_api.dart';
import 'package:firebase_realtime/model/model.dart';
import 'package:open_file/open_file.dart';

class UserDetails extends StatelessWidget {
  final UserModel user;
  const UserDetails({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Align(
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.teal[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: .1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${user.name}'),
              Text('Email: ${user.email}'),
              Text('Phone: ${user.phone}'),
              Text('Product: ${user.product.name} (\$${user.product.price})'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Generate PDF and get the file path
                  String filePath = await PdfApiProvider().createPdf(user);

                  // Navigate to PDF preview screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PdfPreviewScreen(filePath: filePath),
                    ),
                  );
                },
                child: const Text('Preview PDF'),
              ),
              ElevatedButton(
                onPressed: () async {

                  String filePath = await PdfApiProvider().createPdf(user);
                  // Generate PDF and open it directly
                  await PdfApiProvider().createPdf(user);

                  await OpenFile.open(filePath);
                },
                child: const Text('Generate PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
