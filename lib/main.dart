import 'package:chameleon_app/chameleon_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChameleonApp());
}

class ChameleonApp extends StatelessWidget {
  const ChameleonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chameleon App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChameleonPage(),
    );
  }
}