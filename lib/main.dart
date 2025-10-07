import 'package:flutter/material.dart';
import 'package:veda_main/router.dart';

void main() {
  runApp(const VedaMobileApp());
}

class VedaMobileApp extends StatelessWidget {
  const VedaMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Veda System Solutions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // You can use your preferred font
      ),
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
