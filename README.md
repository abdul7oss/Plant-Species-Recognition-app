# Plant Species Recognition App

Technologies used - Flutter , Tensorflow Lite, Tensorflow, Dart.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Convert Tensorflow Model to Tensorflow lite.

# refrence code :    
converter =
tf.lite.TFLiteConverter.from_saved_model(saved_model_dir)
tflite_model = converter.convert()
with open('model.tflite', 'wb') as f:
f.write(tflite_model)



# How to use Tensorflow lite in dart .
visit : https://pub.dev/packages/tflite_flutter

# configure aaptOptions in Android: 
Add the following lines of code to
the android/app/build.gradle file, inside the android block:
aaptOptions {
noCompress 'tflite'
noCompress 'lite'
}

# we need to include the already saved model.tflite and labels.txt files in the assests folder.

# Specify the paths to the files inside the pubspec.yaml file, as follows:
flutter:
uses-material-design: true
//Specify the paths to the respective files
assets:
- assets/model.tflite
- assets/labels.txt





