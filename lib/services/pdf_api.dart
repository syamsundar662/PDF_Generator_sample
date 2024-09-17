import 'dart:io';
import 'package:firebase_realtime/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

int productCount = 1;

class PdfApiProvider {
  Future<String> createPdf(UserModel user) async {
    final pdf = pw.Document();

    //latest
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Invoice',
                    style: const pw.TextStyle(fontSize: 40),
                    textAlign: pw.TextAlign.center),
                pw.SizedBox(height: 20),
                pw.Text('Customer Details:',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text('Name: ${user.name}',
                    style: const pw.TextStyle(fontSize: 15)),
                pw.Text('Phone: ${user.phone}',
                    style: const pw.TextStyle(fontSize: 15)),
                pw.Text('Email: ${user.email}',
                    style: const pw.TextStyle(fontSize: 15)),
                pw.SizedBox(height: 20),
                pw.Text('Product Details:',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  headers: [
                    'Item',
                    'Quantity',
                    'Original Price',
                    'GST (18%)',
                    'Total with GST'
                  ],
                  data: List<List<dynamic>>.generate(
                    user.products.length,
                    (index) => [
                      user.products[index].name,
                      user.quantities[index].toString(),
                      '\$${(user.products[index].price * user.quantities[index]).toStringAsFixed(2)}',
                      '\$${(user.products[index].price * user.products[index].gst * user.quantities[index]).toStringAsFixed(2)}',
                      '\$${(user.products[index].getPriceWithGst() * user.quantities[index]).toStringAsFixed(2)}',
                    ],
                  ),
                  border: pw.TableBorder.all(),
                  cellStyle: const pw.TextStyle(fontSize: 12),
                  headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14),
                  cellAlignment: pw.Alignment.center,
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                        'Total Amount: \$${user.totalPrice.toStringAsFixed(2)}',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text('Thank you for your business!',
                    style: const pw.TextStyle(fontSize: 12)),
                pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Invoice title

                    pw.Text('Onwords Smart Solutions',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(
                        '2/68, First Floor, Avinashi Rd,\nChinniyampalayam, Coimbatore,\nTamil Nadu 641062'),
                    // pw.Text('Tamil Nadu'),
                    pw.Text('Phone: 077086 30275'),
                    pw.Text('Email: onwords@gmail.com'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    // Save PDF file
    Directory? output = await getExternalStorageDirectory();
    output ??= await getApplicationDocumentsDirectory();
    final file =
        File('${output.path}/${user.name.replaceAll(" ", "_")}_invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }
}
