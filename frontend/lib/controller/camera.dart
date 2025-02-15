import 'package:camera/camera.dart';

class CameraProvider {
  static final CameraProvider _instance = CameraProvider._internal();

  factory CameraProvider() {
    return _instance;
  }

  CameraProvider._internal();

  // The list of available cameras
  List<CameraDescription>? cameras;

  // Method to initialize the cameras list
  Future<void> initCameras() async {
    try {
      cameras = await availableCameras(); // Fetch the available cameras
    } catch (e) {
      print("Error getting cameras: $e");
    }
  }
}
