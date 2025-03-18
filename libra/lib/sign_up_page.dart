import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Data/userLogin.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Data/global.dart';

final storage = FlutterSecureStorage();
final logger = Logger();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();
final uri = GlobalState.instance.uri;

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  Future<void> _signup() async {
    final Map<String, dynamic> requestBody = {
      'username': _usernameController.text,
      'password': _passwordController.text,
      'email': _emailController.text
    };
    final url = Uri.parse("$uri/register/");
    final String jsonBody = json.encode(requestBody);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Add other headers if necessary
      },
      body: jsonBody,
    );
    logger.d(response.body);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    logger.d("response: ${response.body} ");
    SignUp signUp = SignUp.fromJson(responseJson);
    logger.d("serialized:  ${signUp.access} ${signUp.message}");
    await storage.write(key: 'access', value: signUp.access);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 100,
              color: Colors.black,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _signup();
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
