import 'package:flutter/material.dart';
import 'techniques/binural_beats.dart';
import 'techniques/box_breathing.dart';
import 'techniques/guided_meditation.dart';
import 'techniques/nature_sounds.dart';
import 'techniques/wood_soup.dart';

//Home page
class Home extends StatefulWidget {
  final String user;
  final List<String> userTags;
  const Home({super.key, required this.user, required this.userTags});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              textAlign: TextAlign.center,
            ),
        ],
        )
      )
    );
  }
}