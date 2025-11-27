import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pick_tags.dart';
import 'classes/user.dart';
import 'classes/color_manager.dart';
import 'classes/notification_manager.dart';

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

  @override
  void initState() {
    super.initState();
    box.clear();
    NotificationManager().cancelAllNotifications();
  }
  
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
              child: Text(
                'OK',
                style: TextStyle(
                  color: ColorManager.secondary
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), 
            width: 1,
          ),
        ),
          titleTextStyle: TextStyle(
            color: ColorManager.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 32

          ),
          contentTextStyle: TextStyle(color: ColorManager.secondary),
        );
      },
    );
  }

  //Logic to handle sign ups
  void _addUser() {

    final username = _usernameController.text.trim();

    //Empty field
    if (username.isEmpty) {
      _showAlertDialog('ERROR', 'Please enter your name!');
      return;
    }

    if(username.length > 12) {
      _showAlertDialog('ERROR', 'Please enter a name less than 12 characters!');
      return;
    }

    if(username.length < 3) {
      _showAlertDialog('ERROR', 'Please enter a name with at least 3 characters!');
      return;
    }

    //Prepare user to be stored in the box
    final user = User(
      username: username,
      tags: [],
      streak: 1,
      lastLogin: DateTime.now(),
      favoriteTechniqueNames: [],
      notificationTime: null,
    );
    
    //Add user to box
    box.put(username, user);

    _showAlertDialog('SUCCESS', 'Logged in!',
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
      backgroundColor: ColorManager.secondary,
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
                color: ColorManager.primary,
              ),
            ),
            Text(
              'Enter your name to get started:',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.textColor
              ),
            ),
            SizedBox(height: 20),

            //Username Input
            SizedBox(
              width: 250,
              child: TextField(
                controller: _usernameController,
                cursorColor: ColorManager.primary,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_4, color: ColorManager.primary),
                  labelText: '',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: 2.0,
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            //Continue Button
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    side: BorderSide(color: ColorManager.primary),
                  ),
                  minimumSize: Size(120, 50)
                ),
                onPressed: _addUser,
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: ColorManager.secondary,
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