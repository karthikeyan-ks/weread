import 'package:flutter/material.dart';
import 'package:libra/sign_up_page.dart';
import 'dart:async';
import 'login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Data/userLogin.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

final logger = Logger();
final storage = FlutterSecureStorage();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAccessToken(); // Call the async method without await
  }

  Future<void> _deleteAppData() async {
    await storage.deleteAll();
  }

  Future<void> _checkToken() async {
    final access = await storage.read(key: "access");

    logger.d(access);
    if (access != null) {
      final url = Uri.parse('https://weread-nine.vercel.app/signup/');
      final Map<String, dynamic> requestBody = {'access_token': access};
      final String jsonBody = json.encode(requestBody);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $access', // Include the access token here
          'Content-Type': 'application/json', // Add other headers if necessary
        },
        body: jsonBody,
      );
      logger.d(response.body);
      Map<String, dynamic> resAuth = jsonDecode(response.body);
      logger.d(resAuth);
      AuthResponse authResponse = AuthResponse.fromJson(resAuth);
      logger.d(authResponse.message);
      if (authResponse.isSuccess) {
        logger.d("authentication successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()), // HomeScreen is now recognized
        );
      }
    }
  }

  // Asynchronous function to handle token check
  Future<void> _checkAccessToken() async {
    final storage = FlutterSecureStorage();
    final access = await storage.read(key: 'access');
    logger.d(access);
    if (access == null) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      });
    } else {
      _checkToken();
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
