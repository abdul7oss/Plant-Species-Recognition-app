import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite/tflite.dart';

class PlantSpeciesRecognition extends StatefulWidget {
  PlantSpeciesRecognition(int a);

  @override
  _PlantSpeciesRecognitionState createState() =>
      _PlantSpeciesRecognitionState();
}

class _PlantSpeciesRecognitionState extends State<PlantSpeciesRecognition> {
  var File_image;
  bool _busy = false;
  var _image;
  List _recognitions;

  Future analyzeTFLite() async {
    String res = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1 // defaults to 1
        );
    print('Model Loaded: $res');
    var recognitions = await Tflite.runModelOnImage(path: _image.path);
    setState(() {
      _recognitions = recognitions;
    });
    print('Recognition Result: $_recognitions');
  }

  Future chooseImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
//Deciding on which method should be chosen for image analysis
    analyzeTFLite();
    setState(() {
      _image = image;
      _busy = false;
    });
  }

  Widget build(
    BuildContext context,
  ) {
    List<Widget> stackChildren = [];
    Size size = MediaQuery.of(context).size;

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null ? Text('No Image Selected') : Image.file(_image),
    ));
    stackChildren.add(Center(
      child: Column(
        children: _recognitions != null
            ? _recognitions.map((res) {
                return Text(
                  "${res["label"]}: ${res["confidence"].toStringAsFixed(4)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    background: Paint()..color = Colors.white,
                  ),
                );
              }).toList()
            : [],
      ),
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Species Recognition'),
      ),
      //Add stackChildren in body
      body: Stack(
        children: stackChildren,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: chooseImageGallery,
        tooltip: 'Pick Image',
        child: Icon(Icons.image),
      ),
    );
  }
}
