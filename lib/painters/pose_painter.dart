import 'package:flutter/material.dart';
import '../models/posture_landmarks.dart';

class PosePainter extends CustomPainter {
  final PostureLandmarks posture;

  PosePainter(this.posture);

  @override
  void paint(Canvas canvas, Size size) {
    final pointPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;

    Offset? ear;
    Offset? shoulder;
    Offset? hip;

    if (posture.rightEar != null) {
      ear = Offset(
        posture.rightEar!.x,
        posture.rightEar!.y,
      );
    }

    if (posture.rightShoulder != null) {
      shoulder = Offset(
        posture.rightShoulder!.x,
        posture.rightShoulder!.y,
      );
    }

    if (posture.rightHip != null) {
      hip = Offset(
        posture.rightHip!.x,
        posture.rightHip!.y,
      );
    }

    if (ear != null) {
      canvas.drawCircle(ear, 10, pointPaint);
    }

    if (shoulder != null) {
      canvas.drawCircle(shoulder, 10, pointPaint);
    }

    if (hip != null) {
      canvas.drawCircle(hip, 10, pointPaint);
    }

    if (ear != null && shoulder != null) {
      canvas.drawLine(
        ear,
        shoulder,
        linePaint,
      );
    }

    if (shoulder != null && hip != null) {
      canvas.drawLine(
        shoulder,
        hip,
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}