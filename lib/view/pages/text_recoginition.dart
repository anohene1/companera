import 'dart:io';

import 'package:companera/services/image_processor.dart';
import 'package:companera/services/text_to_speech.dart';
import 'package:companera/view/widgets/big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  final ImageProcessor imageProcessor = ImageProcessor();
  final TextToSpeech textToSpeech = TextToSpeech();
  final imagePicker = ImagePicker();
  // Variable declarations
  File? imageFile;

  void pickImage(ImageSource source) async {
    final selectedImage = File(
      await imagePicker.pickImage(source: source).then(
            (pickedFile) => pickedFile!.path,
          ),
    );
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedImage.path,
        androidUiSettings: const AndroidUiSettings(
            lockAspectRatio: false,
            toolbarWidgetColor: Color(0xff246CFE),
            toolbarTitle: 'Crop Photo',
            toolbarColor: Color(0xFF1D192D),
            statusBarColor: Color(0xFF1D192D),
            activeControlsWidgetColor: Color(0xFF1D192D),
            backgroundColor: Color(0xFF1D192D),
            hideBottomControls: true));
    setState(() {
      // imageFile = File(pickedImage!.path);
      imageFile = File(croppedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageFile == null
              ? const Icon(
                  Icons.photo,
                  size: 50,
                )
              : Image.file(
                  imageFile!,
                  height: 300,
                ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: BigButton(
                    label: 'Pick Image',
                    icon: CupertinoIcons.photo,
                    onTap: () {
                      pickImage(ImageSource.gallery);
                    },
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: BigButton(
                    label: 'Take Picture',
                    icon: CupertinoIcons.camera,
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BigButton(
                      label: 'Start Reading',
                      icon: CupertinoIcons.play_arrow_solid,
                      onTap: () async {
                        String recognizedText =
                            await imageProcessor.processImage(imageFile!);
                        textToSpeech.speak(recognizedText);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: BigButton(
                      label: 'Stop Reading',
                      icon: CupertinoIcons.pause_fill,
                      onTap: () {
                        textToSpeech.stop();
                      },
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
