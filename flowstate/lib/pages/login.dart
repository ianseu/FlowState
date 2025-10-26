import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcrypt/bcrypt.dart';
import 'sign_up.dart';
import 'home.dart';
import 'user.dart';

//Login page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //User input fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //Hive storage 'box'
  var box = Hive.box('Users');

  //Alert response based on field entry by the user
  void _showAlertDialog(String title, String message, {VoidCallback? onOkPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                if (onOkPressed != null) {
                  onOkPressed(); 
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //Logic to handle logging in
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    //Empty field
    if (username.isEmpty || password.isEmpty) {
      _showAlertDialog('Error', 'All fields are required!');
      return;
    }

    final user = box.get(username) as User?;

    //Check if username exists
    if (user == null) {
      _showAlertDialog('Error', 'Username not found! Sign up first!');
      return;
    }

    //Check if password is correct
    if (BCrypt.checkpw(password, user.hashedPassword!)) { 
      _showAlertDialog('Success', 'Logged in!', 
        onOkPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
      },
    );
  }
    else { 
      _showAlertDialog('Error', 'Incorrect password!');
      return;
    }
  }

  //Clean up memory
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //UI 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Username Input
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            //Password Input
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            //Login Button
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),

            Text('Don\'t have an account?'),
            //Sign up Text Button
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}