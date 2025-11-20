import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../classes/color_manager.dart';

class VideoTechnique extends StatefulWidget {
  final String videoURL;
  const VideoTechnique({super.key, required this.videoURL});

  @override
  State<VideoTechnique> createState() => _VideoTechniqueState();
}

class _VideoTechniqueState extends State<VideoTechnique> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState(){
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoURL);
    _videoPlayerController?.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
        aspectRatio: 16/9,
        allowedScreenSleep: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: ColorManager.primary,
          handleColor: ColorManager.primary,
          backgroundColor: Color.fromARGB(255, 73, 73, 73),
          bufferedColor: Colors.grey,
        ),
      );
      setState(() {});
    });
  }
  
  Widget _checkChewieController() {
    if (_chewieController != null) {
      return Chewie(
        controller: _chewieController!,
      );
    } 
    else {
      return CircularProgressIndicator();
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Back",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          )
          ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 40
        ),
      ),
      body: Center(
        child: _checkChewieController(),
      ),
    );
  }
}