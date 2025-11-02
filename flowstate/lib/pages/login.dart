import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcrypt/bcrypt.dart';
import 'sign_up.dart';
import 'home.dart';
import 'classes/user.dart';

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

    List<String>? tags = [];
    
    //Check if password is correct
    if (BCrypt.checkpw(password, user.hashedPassword!)) { 
      _showAlertDialog('Success', 'Logged in!', 
        onOkPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home(user: username, userTags: tags)),
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

            //Logo
            Image.asset(
              'assets/icons/app_icon.png',
              width: 150,
              height: 150,
            ),


            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(84, 125, 194, 1)
              ),
            ),
            SizedBox(height: 40),

            //Username Input
            SizedBox(
              width: 300,
              child: TextField(
                controller: _usernameController,
                cursorColor: Color.fromRGBO(84, 125, 194, 1),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Color.fromRGBO(84, 125, 194, 1)),
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color.fromRGBO(84, 125, 194, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 125, 194, 1),
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 125, 194, 1),
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 125, 194, 1),
                      width: 2.0,
                    )
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 10),

            //Password Input
            SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordController,
                cursorColor: Color.fromRGBO(84, 125, 194, 1),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(84, 125, 194, 1)),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color.fromRGBO(84, 125, 194, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 125, 194, 1),
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 125, 194, 1),
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 125, 194, 1),
                      width: 2.0,
                    )
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 10),

            //Login Button
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(84, 125, 194, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    side: BorderSide(color: Color.fromRGBO(84, 125, 194, 1)),
                  ),
                ),
                onPressed: _login,
                child: Text(
                'Login',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            Text('Don\'t have an account?'),
            //Sign up Text Button
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Color.fromRGBO(84, 125, 194, 1),
                ),
                  
              ),
            ),
          ],
        ),
      ),
    );
  }
}