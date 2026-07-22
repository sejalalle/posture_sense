import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;

  Future<void> initialize() async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();
  }

  Future<XFile?> captureFrame() async {
    if (controller == null) return null;

    if (!controller!.value.isInitialized) return null;

    if (controller!.value.isTakingPicture) return null;

    return await controller!.takePicture();
  }

  void dispose() {
    controller?.dispose();
  }
}