import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/classes/user.dart'; 
import 'pages/welcome.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowState',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
        splashColor: Colors.transparent,  
        highlightColor: Colors.transparent,
        primaryColor: Color.fromRGBO(84, 125, 194, 1),
      ),
      home: WelcomePage(),
    );
  }
}