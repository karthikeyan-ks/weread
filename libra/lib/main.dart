import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(WeReadApp());
}

class WeReadApp extends StatelessWidget {
  const WeReadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
