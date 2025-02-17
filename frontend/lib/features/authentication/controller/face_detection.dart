import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectionService {
  static Future<bool> detectSingleFace(File image) async {
    final faceDetector = FaceDetector(options: FaceDetectorOptions());
    final InputImage inputImage = InputImage.fromFile(image);

    final List<Face> faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();

    return faces.length == 1; 
  }
}
