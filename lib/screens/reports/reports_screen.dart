import 'package:flutter/material.dart';

import '../../services/history_service.dart';
import '../../services/pdf_service.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final HistoryService historyService = HistoryService();
  final PdfService pdfService = PdfService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export Report"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text("Generate PDF"),
          onPressed: () async {
            final history =
                await historyService.getHistory().first;

            await pdfService.generateReport(history);
          },
        ),
      ),
    );
  }
}