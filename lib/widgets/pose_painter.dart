import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PosePainter extends CustomPainter {
  final List<Pose> poses;
  final Size imageSize;

  PosePainter({
    required this.poses,
    required this.imageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (poses.isEmpty) return;

    final Paint pointPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;

    for (final pose in poses) {
      final landmarks = pose.landmarks;

      // Draw every landmark
      for (final landmark in landmarks.values) {
        final Offset point = Offset(
          landmark.x * size.width / imageSize.width,
          landmark.y * size.height / imageSize.height,
        );

        canvas.drawCircle(point, 5, pointPaint);
      }

      void drawConnection(
        PoseLandmarkType first,
        PoseLandmarkType second,
      ) {
        final p1 = landmarks[first];
        final p2 = landmarks[second];

        if (p1 == null || p2 == null) return;

        final Offset start = Offset(
          p1.x * size.width / imageSize.width,
          p1.y * size.height / imageSize.height,
        );

        final Offset end = Offset(
          p2.x * size.width / imageSize.width,
          p2.y * size.height / imageSize.height,
        );

        canvas.drawLine(start, end, linePaint);
      }

      // Head
      drawConnection(PoseLandmarkType.nose, PoseLandmarkType.leftEye);
      drawConnection(PoseLandmarkType.nose, PoseLandmarkType.rightEye);

      drawConnection(PoseLandmarkType.leftEye, PoseLandmarkType.leftEar);
      drawConnection(PoseLandmarkType.rightEye, PoseLandmarkType.rightEar);

      // Shoulders
      drawConnection(
          PoseLandmarkType.leftShoulder,
          PoseLandmarkType.rightShoulder);

      // Arms
      drawConnection(
          PoseLandmarkType.leftShoulder,
          PoseLandmarkType.leftElbow);

      drawConnection(
          PoseLandmarkType.leftElbow,
          PoseLandmarkType.leftWrist);

      drawConnection(
          PoseLandmarkType.rightShoulder,
          PoseLandmarkType.rightElbow);

      drawConnection(
          PoseLandmarkType.rightElbow,
          PoseLandmarkType.rightWrist);

      // Torso
      drawConnection(
          PoseLandmarkType.leftShoulder,
          PoseLandmarkType.leftHip);

      drawConnection(
          PoseLandmarkType.rightShoulder,
          PoseLandmarkType.rightHip);

      drawConnection(
          PoseLandmarkType.leftHip,
          PoseLandmarkType.rightHip);

      // Legs
      drawConnection(
          PoseLandmarkType.leftHip,
          PoseLandmarkType.leftKnee);

      drawConnection(
          PoseLandmarkType.leftKnee,
          PoseLandmarkType.leftAnkle);

      drawConnection(
          PoseLandmarkType.rightHip,
          PoseLandmarkType.rightKnee);

      drawConnection(
          PoseLandmarkType.rightKnee,
          PoseLandmarkType.rightAnkle);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}