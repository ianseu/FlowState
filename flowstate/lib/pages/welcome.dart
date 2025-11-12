import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pick_tags.dart';
import 'classes/user.dart';

//Sign up page
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //User input fields
  final TextEditingController _usernameController = TextEditingController();
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
  void _addUser() {

    final username = _usernameController.text.trim();

    //Empty field
    if (username.isEmpty) {
      _showAlertDialog('Error', 'Please enter your name!');
      return;
    }

    if(username.length > 12) {
      _showAlertDialog('Error', 'Please enter a name less than 12 characters!');
      return;
    }

    //Prepare user to be stored in the box
    final user = User(
      username: username,
      tags: [], //Tags will be added later after sign up
      streak: 1,
      // lastLogin: ADD LATER
    );
    
    //Add user to box
    box.put(username, user);

    _showAlertDialog('Success', 'Sign-up successful!',
      onOkPressed: () {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PickTags(user: username)),
      );
    },
  );
 
  }

  //Clean up memory
  @override
  void dispose() {
    _usernameController.dispose();
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
              'Welcome!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(84, 125, 194, 1)
              ),
            ),
            Text(
              'Enter your name to get started:',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 1)
              ),
            ),
            SizedBox(height: 20),

            //Username Input
            SizedBox(
              width: 300,
              child: TextField(
                controller: _usernameController,
                cursorColor: Color.fromRGBO(84, 125, 194, 1),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Color.fromRGBO(84, 125, 194, 1)),
                  labelText: '',
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
            SizedBox(height: 20),

            //Sign up Button
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(84, 125, 194, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    side: BorderSide(color: Color.fromRGBO(84, 125, 194, 1)),
                  ),
                  minimumSize: Size(120, 50)
                ),
                onPressed: _addUser,
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}