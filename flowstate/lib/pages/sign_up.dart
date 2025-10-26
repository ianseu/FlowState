import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcrypt/bcrypt.dart';
import 'login.dart';
import 'pick_tags.dart';
import 'user.dart';

//Sign up page
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //User input fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
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

  //Logic to handle sign ups
  void _signUp() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    //Empty field
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showAlertDialog('Error', 'All fields are required!');
      return;
    }

    //Different password entries
    if (password != confirmPassword) {
      _showAlertDialog('Error', 'Passwords do not match!');
      return;
    }

    //User already exists
    if (box.containsKey(username)) {
      _showAlertDialog('Error', 'Username already exists!');
      return;
    }

    //Hash password for security
    final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    //Prepare user to be stored in the box
    final user = User(
      username: username,
      hashedPassword: hashedPassword,
      tags: [], //Tags will be added later after sign up
    );
    
    //Add user to box
    box.put(username, user);

    _showAlertDialog('Success', 'Sign-up successful!',
      onOkPressed: () {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PickTags()),
      );
    },
  );
 
  }

  //Clean up memory
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              'Create Account',
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

            //Confirm Password Input
            SizedBox(
              width: 300,
              child: TextField(
                controller: _confirmPasswordController,
                cursorColor: Color.fromRGBO(84, 125, 194, 1),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(84, 125, 194, 1)),
                  labelText: 'Confirm Password',
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

            //Sign up Button
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(84, 125, 194, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    side: BorderSide(color: Color.fromRGBO(84, 125, 194, 1)),
                  ),
                ),
                onPressed: _signUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),

            Text('Already have an account?'),
            //Login Text Button
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Login',
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