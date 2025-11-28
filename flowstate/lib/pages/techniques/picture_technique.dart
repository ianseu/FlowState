import 'package:flutter/material.dart';

class PictureTechnique extends StatefulWidget {
  final String imagePath;
  final Color themeColor;
  final double width;
  final double height;
  const PictureTechnique({super.key, required this.imagePath, required this.themeColor, required this.width, required this.height});

  @override
  State<PictureTechnique> createState() => _PictureTechniqueState();
}

class _PictureTechniqueState extends State<PictureTechnique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          )         
        ),
        backgroundColor: widget.themeColor,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 40
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: widget.themeColor,
        child: Image.asset(
          widget.imagePath,
          width: widget.width,
          height: widget.height,
          ),
      ),
    );
  }
}