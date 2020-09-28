import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './plant_species_recognition.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var str_cloud = 'Cloud Vision API';
  var str_tensor = 'TensorFlow Lite';
  @override
  Widget buildRowTitle(BuildContext context, String title) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    ));
  }

  Widget createButton(String chosenModel) {
    return (RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        splashColor: Colors.blueGrey,
        child: new Text(chosenModel),
        onPressed: () {
          var a = (chosenModel == str_cloud ? 0 : 1);
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => PlantSpeciesRecognition(a)),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Plant Species Recognition'),
            ),
            body: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildRowTitle(context, 'Choose Model'),
                createButton(str_cloud),
                createButton(str_tensor),
              ],
            ))));
  }
}
