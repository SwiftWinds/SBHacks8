import 'package:discovar/model/tour_point.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:collection/collection.dart';

List<CameraDescription>? cameras;

class CameraPage extends StatefulWidget {
  const CameraPage(this.setCurrentTourPoint, this.tourPoints, {Key? key}) : super(key: key);

  final dynamic setCurrentTourPoint;
  final List<TourPoint> tourPoints;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? cameraController;
  CameraImage? cameraImage;
  List? recognitionsList;
  Stopwatch stopwatch = Stopwatch()..start();

  initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController?.initialize().then((value) {
      setState(() {
        cameraController?.startImageStream((image) {
          cameraImage = image;
          if (stopwatch.elapsedMilliseconds > 500) {
            runModel();
            stopwatch.reset();
          }
        });
      });
    });
  }

  runModel() async {
    recognitionsList = await Tflite.detectObjectOnFrame(
      bytesList: cameraImage!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: cameraImage!.height,
      imageWidth: cameraImage!.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.8,
    );

    setState(() {
      cameraImage;
    });
  }

  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(model: "assets/ssd_mobilenet.tflite");
  }

  @override
  void dispose() {
    super.dispose();

    cameraController?.stopImageStream();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();

    loadModel();
    initCamera();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (recognitionsList == null) return [];

    double factorX = screen.width;
    double factorY = screen.height;

    Color colorPick = Colors.pink;

    return recognitionsList!.map((result) {
      return Positioned(
        left: result["rect"]["x"] * factorX,
        top: result["rect"]["y"] * factorY,
        width: result["rect"]["w"] * factorX,
        height: result["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var confidentRecognition = recognitionsList?.firstWhereOrNull((recognition) => recognition['confidenceInClass'] > 0.85);
    if (confidentRecognition != null)
    {
      var tourPoint = widget.tourPoints.firstWhereOrNull((tourPoint) => tourPoint.mlClassID == confidentRecognition['detectedClass']);
      if (tourPoint != null)
      {
        widget.setCurrentTourPoint();
        Navigator.pop(context);
      }
    }

    Size size = MediaQuery.of(context).size;
    List<Widget> list = [];

    if (cameraController != null)
    {
      list.add(
        Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height - 100,
          child: SizedBox(
            height: size.height - 100,
            child: (!cameraController!.value.isInitialized)
                ? Container()
                : AspectRatio(
              aspectRatio: cameraController!.value.aspectRatio,
              child: CameraPreview(cameraController!),
            ),
          ),
        ),
      );
    }

    if (cameraImage != null) {
      list.addAll(displayBoxesAroundRecognizedObjects(size));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan Places'),
        ),
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Stack(
            children: list,
          ),
        ),
      ),
    );
  }
}