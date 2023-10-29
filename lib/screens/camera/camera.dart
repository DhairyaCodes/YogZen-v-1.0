import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
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

  @override
  void initState() {
    loadCamera();
    loadModel();
    super.initState();
  }

  void disposeModel() {
    Tflite.close();
  }

  @override
  void dispose() {
    disposeModel();
    super.dispose();
  }

  void loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController?.startImageStream((imageStream) {
          cameraImage = imageStream;
          runModel();
        });
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        print(e.description);
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

  void runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      predictions?.forEach((element) {
        setState(() {
          output = element["label"] +
              " " +
              (element["confidence"] as double).toStringAsFixed(2) +
              "\n\n";
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yoga Model"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: (!cameraController!.value.isInitialized)
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Text(
            output,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
