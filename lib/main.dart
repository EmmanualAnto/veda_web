import 'package:flutter/material.dart';
import 'package:veda_main/home.dart';

void main() {
  runApp(const VedaMobileApp());
}

class VedaMobileApp extends StatelessWidget {
  const VedaMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veda System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // You can use your preferred font
      ),
      home: const VedaHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
