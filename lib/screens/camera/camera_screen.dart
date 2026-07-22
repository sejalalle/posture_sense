import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:uuid/uuid.dart';

import '../../models/posture_history.dart';
import '../../models/posture_landmarks.dart';
import '../../painters/pose_painter.dart';
import '../../services/camera_service.dart';
import '../../services/history_service.dart';
import '../../services/pose_detector_service.dart';
import '../../services/posture_analysis_service.dart';
import '../../widgets/posture_overlay.dart';
import '../results/result_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final CameraService cameraService = CameraService();
  final PoseDetectorService poseService = PoseDetectorService();
  final HistoryService historyService = HistoryService();

  bool loading = true;
  bool detecting = false;

  PostureLandmarks? detectedPosture;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    await cameraService.initialize();

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }
  Future<void> scanPosture() async {
  if (detecting) return;

  detecting = true;

  try {
    final XFile? image =
        await cameraService.captureFrame();

    if (image == null) {
      detecting = false;
      return;
    }

    final inputImage =
        InputImage.fromFile(File(image.path));

    final poses =
        await poseService.detect(inputImage);

    if (poses.isEmpty) {
      detecting = false;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No person detected"),
          ),
        );
      }

      return;
    }

    final posture =
        PostureLandmarks.fromPose(
      poses.first,
    );

    setState(() {
      detectedPosture = posture;
    });

    final report =
        PostureAnalysisService.analyze(posture);

    debugPrint("========== POSTURE REPORT ==========");
    debugPrint("Score : ${report.score}");
    debugPrint("Distance : ${report.neckAngle}");
    debugPrint("Forward Head : ${report.forwardHead}");
    debugPrint("Severity : ${report.severity}");
    debugPrint("orwardHead : ${report.forwardHead}");

    debugPrint("Recommendation : ${report.recommendation}");

    // Save history to Firestore
    final history = PostureHistory(
      id: const Uuid().v4(),
      date: DateTime.now(),
      score: report.score,
      angle: report.neckAngle,
      posture: report.severity,
      forwardHead: report.forwardHead,
      recommendation: report.recommendation,
    );

    await historyService.save(history);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          angle: report.neckAngle,
          forwardHead: report.forwardHead,
          postureText: report.severity,
          score: report.score,
          recommendation: report.recommendation,
        ),
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }

  detecting = false;
}
  @override
  void dispose() {
    cameraService.dispose();
    poseService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Camera Preview
          Positioned.fill(
            child: CameraPreview(
              cameraService.controller!,
            ),
          ),

          /// Human outline overlay
          const PostureOverlay(),

          /// Skeleton overlay after detection
          if (detectedPosture != null)
            Positioned.fill(
              child: CustomPaint(
                painter: PosePainter(
                  detectedPosture!,
                ),
              ),
            ),

          /// Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Posture Scan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  const SizedBox(
                    width: 48,
                  ),
                ],
              ),
            ),
          ),

          /// Instructions
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                "Stand sideways.\nAlign your head and shoulders inside the guide.\nKeep the phone at shoulder height.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          /// Capture Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 35,
              ),
              child: FloatingActionButton.large(
                onPressed: detecting ? null : scanPosture,
                child: detecting
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 34,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}