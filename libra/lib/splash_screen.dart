import 'package:flutter/material.dart';
import 'package:libra/sign_up_page.dart';
import 'dart:async';
import 'login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

final logger = Logger();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAccessToken(); // Call the async method without await
  }

  // Asynchronous function to handle token check
  Future<void> _checkAccessToken() async {
    final storage = FlutterSecureStorage();
    final access = await storage.read(key: 'access');
    if (access == null) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'WeRead',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
