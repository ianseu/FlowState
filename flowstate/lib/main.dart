import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/user.dart'; 
import 'pages/login.dart';

//Main app functionality
void main() async {
  //Boiler code for Hive box database and Flutter framework
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); 
  Hive.registerAdapter(UserAdapter()); 
  await Hive.openBox('Users');
  runApp(const MyApp()); //Runs app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}