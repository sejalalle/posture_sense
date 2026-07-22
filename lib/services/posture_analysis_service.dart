import '../models/posture_landmarks.dart';
import '../models/posture_report.dart';
import 'posture_service.dart';

class PostureAnalysisService {

  static PostureReport analyze(
      PostureLandmarks posture) {

    if (!PostureService.isSideProfile(posture)) {

      return PostureReport(
        score: 0,
        neckAngle: 0,
        forwardHead: false,
        severity: "Stand Sideways",
        recommendation:
            "Please stand sideways for an accurate scan.",
      );
    }

    final angle =
        PostureService.calculateNeckAngle(
            posture);

    double score;

    if (angle >= 55) {
      score = 100;
    } else if (angle >= 50) {
      score = 90;
    } else if (angle >= 45) {
      score = 75;
    } else if (angle >= 40) {
      score = 60;
    } else {
      score = 40;
    }

    String severity;

    if (score == 100) {
      severity = "Excellent";
    } else if (score >= 90) {
      severity = "Good";
    } else if (score >= 75) {
      severity = "Mild Forward Head";
    } else if (score >= 60) {
      severity = "Moderate Forward Head";
    } else {
      severity = "Severe Forward Head";
    }

    String recommendation;

    if (score == 100) {
      recommendation =
          "Maintain your posture.";
    } else if (score >= 90) {
      recommendation =
          "Stretch every hour.";
    } else if (score >= 75) {
      recommendation =
          "Practice chin tucks daily.";
    } else if (score >= 60) {
      recommendation =
          "Improve monitor height and strengthen neck muscles.";
    } else {
      recommendation =
          "Consult a physiotherapist and begin corrective exercises.";
    }

    return PostureReport(
      score: score,
      neckAngle: angle,
      forwardHead: angle < 50,
      severity: severity,
      recommendation: recommendation,
    );
  }
}