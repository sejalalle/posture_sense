import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetectorService {

  final PoseDetector detector = PoseDetector(

    options: PoseDetectorOptions(
      model: PoseDetectionModel.accurate,
    ),

  );

  Future<List<Pose>> detect(InputImage image) async {

    return await detector.processImage(image);

  }

  void dispose(){

    detector.close();

  }

}