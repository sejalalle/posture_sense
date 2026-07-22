import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PostureLandmarks {
  final PoseLandmark? leftEar;
  final PoseLandmark? rightEar;

  final PoseLandmark? leftShoulder;
  final PoseLandmark? rightShoulder;

  final PoseLandmark? leftHip;
  final PoseLandmark? rightHip;

  const PostureLandmarks({
    required this.leftEar,
    required this.rightEar,
    required this.leftShoulder,
    required this.rightShoulder,
    required this.leftHip,
    required this.rightHip,
  });

  factory PostureLandmarks.fromPose(Pose pose) {
    return PostureLandmarks(
      leftEar: pose.landmarks[PoseLandmarkType.leftEar],
      rightEar: pose.landmarks[PoseLandmarkType.rightEar],

      leftShoulder:
          pose.landmarks[PoseLandmarkType.leftShoulder],

      rightShoulder:
          pose.landmarks[PoseLandmarkType.rightShoulder],

      leftHip:
          pose.landmarks[PoseLandmarkType.leftHip],

      rightHip:
          pose.landmarks[PoseLandmarkType.rightHip],
    );
  }
}