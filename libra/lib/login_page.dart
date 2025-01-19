import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // <-- Added this line
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Data/userLogin.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final storage = FlutterSecureStorage();

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final access = await storage.read(key: "access");
    if (access != null) {
      final url = Uri.parse('https://weread-nine.vercel.app/protected/');
      final Map<String, dynamic> requestBody = {'access_token': access};
      final String jsonBody = json.encode(requestBody);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      logger.d(response.body);
    }
  }

  Future<String> fetchData(email, password) async {
    final url = Uri.parse('https://weread-nine.vercel.app/api/token/');
    final Map<String, dynamic> requestBody = {
      'username': email,
      'password': password
    };
    final String jsonBody = json.encode(requestBody);
    logger.d(jsonBody);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    Map<String, dynamic> userMap = jsonDecode(response.body);
    User user = User.fromJson(userMap);

    logger.d(user.access + user.refresh);
    await storage.write(key: 'access', value: user.access);
    await storage.write(key: 'refresh', value: user.refresh);
    if (user.access != "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successfull")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()), // HomeScreen is now recognized
      );
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
    Fluttertoast.showToast(
      msg: response.toString(),
      toastLength: Toast.LENGTH_SHORT, // Duration: LENGTH_SHORT or LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Position: BOTTOM, CENTER, or TOP
      timeInSecForIosWeb: 1, // Duration in seconds for iOS and web
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return response.body;
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    fetchData(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
