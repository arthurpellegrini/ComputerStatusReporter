import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:computer_status_reporter/model/data_controller.dart';
import 'package:computer_status_reporter/qr_code/pdf_generator.dart';


class CustomDownloadQr extends StatefulWidget {
  const CustomDownloadQr({super.key, required this.dataController});

  final DataController dataController;

  @override
  State<CustomDownloadQr> createState() => _CustomDownloadQrState();
}

class _CustomDownloadQrState extends State<CustomDownloadQr> {
  bool _isGeneratingPDF = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isGeneratingPDF ? null : _generatePDF,
      icon: _isGeneratingPDF
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.black,
              ),
            )
          : const Icon(Icons.download, color: Colors.black),
      label: Text(
        AppLocalizations.of(context)!.exportQR,
        style: const TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9F61D1),
        padding: const EdgeInsets.symmetric(vertical: 20),
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(400, 70),
        maximumSize: const Size(2000, 70),
      ),
    );
  }

  Future<void> _generatePDF() async {
    setState(() {
      _isGeneratingPDF = true;
    });

    try {
      PDFGenerator pdfGenerator = PDFGenerator(dataController: widget.dataController);
      Uint8List pdfData = await pdfGenerator.generatePDFWithQR();

      // Display the generated PDF
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfData,
      );
    } finally {
      setState(() {
        _isGeneratingPDF = false;
      });
    }
  }
}