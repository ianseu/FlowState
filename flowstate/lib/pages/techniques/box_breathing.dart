import 'package:flutter/material.dart';

class BoxBreathing extends StatelessWidget {
  const BoxBreathing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 109, 119, 228),
      appBar: AppBar(
        title: Text(
          "Back",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
            )
          ),
        backgroundColor: Color.fromARGB(255, 109, 119, 228),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 40
        ),
      ),
      body: Center(
        child: Image.asset(
          'assets/icons/box_breathing.gif',
          width: 300,
          height: 300,
          )
        ),
    );
  }
}