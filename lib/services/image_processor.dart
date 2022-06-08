import 'dart:io';

import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageProcessor {

  final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();

  Future<String> processImage(File image) async {
    GoogleVisionImage visionImage = GoogleVisionImage.fromFile(image);
    VisionText visionText = await textRecognizer.processImage(visionImage);

    return visionText.text!;
  }
}