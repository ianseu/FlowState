import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/classes/user.dart'; 
import 'pages/welcome.dart';
import 'pages/home.dart';

//adb connect 127.0.0.1:7555 -> connect to MuMu emulator

//Main app functionality
void main() async {
  //Boiler code for Hive box database and Flutter framework
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); 
  Hive.registerAdapter(UserAdapter());
  // var box = 
  await Hive.openBox('Users');
  // box.clear();
  runApp(const MyApp()); //Runs app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _loadUser() {
    var box = Hive.box('Users');
    
    //No User Exists
    if (box.isEmpty) {
      return WelcomePage();
    } 

    //User Exists, update their streak:
    else {
      var user = box.getAt(0);
      
      DateTime today = DateTime.now();
      DateTime todayDate = DateTime(today.year, today.month, today.day);
      DateTime lastLoginDate = DateTime(user.lastLogin.year, user.lastLogin.month, user.lastLogin.day);

      DateTime yesterdayDate = todayDate.subtract(Duration(days: 1));
      
      if (lastLoginDate == yesterdayDate) {
        user.streak += 1;
        user.lastLogin = today;
      } 
      else if (lastLoginDate == todayDate) {
        user.lastLogin = today;
      } 
      else {
        user.streak = 1;
        user.lastLogin = today;
      }
      
      user.save(); 
      
      return Home(user: user.username, userTags: user.tags, streak: user.streak, userLastLogin: user.lastLogin, favoriteTechniques: user.favoriteTechniqueNames);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowState',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      home: _loadUser(),
    );
  }
}