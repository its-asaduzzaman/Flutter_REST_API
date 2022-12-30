import 'package:flutter/material.dart';
import 'package:rest_api_flutter/screens/example_four.dart';
import 'package:rest_api_flutter/screens/example_three.dart';
import 'package:rest_api_flutter/screens/last_get_api_example.dart';
import 'package:rest_api_flutter/screens/signup_screen.dart';
import 'package:rest_api_flutter/screens/third_screen.dart';
import 'package:rest_api_flutter/screens/upload_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageUploadScreen(),
    );
  }
}
