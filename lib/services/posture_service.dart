import 'dart:math';
import '../models/posture_landmarks.dart';

class PostureService {

  static bool isSideProfile(PostureLandmarks p) {

    if (p.leftShoulder == null ||
        p.rightShoulder == null) {
      return false;
    }

    final shoulderDistance =
        (p.leftShoulder!.x -
                p.rightShoulder!.x)
            .abs();

    return shoulderDistance < 120;
  }

  static double calculateNeckAngle(
      PostureLandmarks p) {

    if (p.rightEar == null ||
        p.rightShoulder == null ||
        p.rightHip == null) {
      return 0;
    }

    final ear = p.rightEar!;
    final shoulder = p.rightShoulder!;
    final hip = p.rightHip!;

    final ax = ear.x - shoulder.x;
    final ay = ear.y - shoulder.y;

    final bx = hip.x - shoulder.x;
    final by = hip.y - shoulder.y;

    final dot = ax * bx + ay * by;

    final magA = sqrt(ax * ax + ay * ay);
    final magB = sqrt(bx * bx + by * by);

    if (magA == 0 || magB == 0) {
      return 0;
    }

    double cosTheta = dot / (magA * magB);

    cosTheta = cosTheta.clamp(-1.0, 1.0);

    final angle =
        acos(cosTheta) * 180 / pi;

    return angle;
  }

  static bool isForwardHead(
      PostureLandmarks p) {

    final angle = calculateNeckAngle(p);

    return angle < 50;
  }
}