import 'package:camera/camera.dart';
import 'package:companera/services/sign_language_detector.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';


class SignLanguageScreen extends StatefulWidget {
  const SignLanguageScreen({Key? key, }) : super(key: key);

  @override
  State<SignLanguageScreen> createState() => _SignLanguageScreenState();
}


class _SignLanguageScreenState extends State<SignLanguageScreen> {

  List<CameraDescription>? _cameras;
  late CameraController controller;
  String? label = '';
  bool isCameraReady = false;

  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[0];
    _controller = CameraController(firstCamera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller?.initialize().then((_) async {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraReady = true;
      });

      await Tflite.loadModel(
        model: "assets/model/models.tflite",
        labels: "assets/model/labels.txt",
      );
      print('start');
      _controller?.startImageStream(
            (image) async {
          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            threshold: 0.5,
            numResults: 1,
            asynch: true,
          ).then((value) {
            value?.map((res) {});
            print(value?.first);
            //   print('yes');
            setState(() {
              label = value?.first['label'].toString();
            });
            //   print(label);
          });
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }



  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 5,
            child: isCameraReady ? Container(
              width: double.infinity,
              child: CameraPreview(_controller!),
            ) : Container(),
          ),
          Flexible(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Position ASL signs in the viewfinder above to get the English equivalent below :',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$label',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}