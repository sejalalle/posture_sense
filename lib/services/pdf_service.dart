import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/posture_history.dart';

class PdfService {
  Future<void> generateReport(
    List<PostureHistory> history,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [

          pw.Text(
            "PostureSense Report",
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 20),

          ...history.map(
            (item) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 12),
              child: pw.Column(
                crossAxisAlignment:
                    pw.CrossAxisAlignment.start,
                children: [

                  pw.Text("Score : ${item.score}"),

                  pw.Text("Angle : ${item.angle}"),

                  pw.Text("Posture : ${item.posture}"),

                  pw.Text(
                      "Recommendation : ${item.recommendation}"),

                  pw.Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}