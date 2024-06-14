import 'dart:typed_data';
import 'dart:ui';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:computer_status_reporter/src/model/computer.dart';

class PDFGenerator {
  final DataController dataController;

  PDFGenerator({required this.dataController});

  Future<Uint8List> generatePDFWithQR() async {
    final pdf = pw.Document();

    // Fetch computers from DataController
    await dataController.createComputersList();
    Map<String, List<Computer>> computers = dataController.getComputers();
    List<Computer> allComputers =
        computers.values.expand((list) => list).toList();

    // Pre-generate QR codes for all computers
    Map<String, Uint8List> qrImages = {};
    for (var computer in allComputers) {
      qrImages[computer.computerName] =
          await _generateQrImage(computer.computerName);
    }

    // Partition the list of computers into chunks of 8
    List<List<Computer>> pages = partition(allComputers, 8);

    for (var page in pages) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.GridView(
              crossAxisCount: 2, // Ajusté pour 4 QR codes par ligne
              childAspectRatio: 1,
              children: page.map((computer) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(computer.toString(),
                          textAlign: pw.TextAlign.center),
                      pw.SizedBox(height: 10),
                      pw.Image(pw.MemoryImage(qrImages[computer.computerName]!),
                          width: 100, height: 100),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      );
    }
    return pdf.save();
  }

  Future<Uint8List> _generateQrImage(String data) async {
    final qrCode = await QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: true,
    ).toImage(200);

    final qrCodeBytes = await qrCode.toByteData(format: ImageByteFormat.png);
    return qrCodeBytes!.buffer.asUint8List();
  }
}

// Util function to partition a list into chunks
List<List<T>> partition<T>(List<T> list, int size) {
  List<List<T>> chunks = [];
  for (var i = 0; i < list.length; i += size) {
    int end = (i + size < list.length) ? i + size : list.length;
    chunks.add(list.sublist(i, end));
  }
  return chunks;
}
