import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // <-- Added this line
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Data/userLogin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String> fetchData(email, password) async {
    final url = Uri.parse('http://192.168.1.39:8000/signup/');
    final Map<String, dynamic> requestBody = {
      'username': email,
      'password': password
    };
    final String jsonBody = json.encode(requestBody);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    User user = User(response.body);
    if (user.message == "success") {
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

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;
    Future<String> response = fetchData(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Button color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white), // Text color
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign Up Here'),
            ),
          ],
        ),
      ),
    );
  }
}
