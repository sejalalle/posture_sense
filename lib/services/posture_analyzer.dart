import '../models/posture_result.dart';

class PostureAnalyzer {

  static PostureResult analyze({

    required double neck,
    required double shoulder,

  }) {

    String result;

    if (neck < 25) {

      result = "Excellent";

    } else if (neck < 40) {

      result = "Good";

    } else if (neck < 55) {

      result = "Forward Head";

    } else {

      result = "Severe Forward Head";

    }

    return PostureResult(

      neckAngle: neck,
      shoulderAngle: shoulder,
      posture: result,
      time: DateTime.now(),

    );

  }

}