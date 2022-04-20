import 'dart:io';

import 'package:companera/constants/button_styles.dart';
import 'package:companera/view/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {


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
        androidUiSettings: AndroidUiSettings(
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageFile == null ? Icon(Icons.photo, size: 50,) : Image.file(imageFile!, height: 300,),
          SizedBox(height: 20,),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BigButton(label: 'Pick Image', icon: Icons.photo, onTap: (){
                    pickImage(ImageSource.gallery);
                  },)),
                  SizedBox(width: 20,),
                  Expanded(child: BigButton(label: 'Take Picture', icon: Icons.photo, onTap: () {
                    pickImage(ImageSource.camera);
                  },)),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BigButton(label: 'Start Reading', icon: Icons.photo)),
                  SizedBox(width: 20,),
                  Expanded(child: BigButton(label: 'Stop Reading', icon: Icons.photo)),

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}