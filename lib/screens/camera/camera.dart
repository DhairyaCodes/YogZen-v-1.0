import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yogzen_v_1/main.dart';

class Camera extends StatefulWidget {
  static const routeName = "/cameraScreen";
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "";

  void loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController?.startImageStream((imageStream) {
          cameraImage = imageStream;
        });
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
    );
  }
}
