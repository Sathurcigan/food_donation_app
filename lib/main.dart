import 'package:flutter/material.dart';
import 'package:food_donation_app/screens/welcome_screen.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Welcome_screen(),
      title: appName,
    );
  }
}
