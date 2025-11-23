import 'package:flutter/material.dart';
import '../techniques/box_breathing.dart';
import '../techniques/video_technique.dart';

class Technique {
  String name;
  String description;
  String image;
  List<String> tags;          
  List<String> strugglesTags;  
  List<String> durationsTags;
  Widget destination;

  Technique({
    required this.name,
    required this.description,
    required this.image,
    required this.tags,
    required this.strugglesTags,
    required this.durationsTags,
    required this.destination,
  });
}

// List of all techniques
List<Technique> allTechniques = [
  Technique(
    name: "Binaural Beats",
    description: "Intense auditory experience",
    image: "assets/icons/binaural_beats.png",
    tags: ["Auditory"],
    strugglesTags: ["Focus", "Poor Sleep"],
    durationsTags: ["Under 5 Min", "Over 5 Min"],
    destination: VideoTechnique(videoURL: "https://flow-state-2025.s3.us-east-2.amazonaws.com/binaural_beats.mp4"),
  ),
  Technique(
    name: "Box Breathing",
    description: "Controlled breathing exercise",
    image: "assets/icons/box_breathing.png",
    tags: ["Visual"],
    strugglesTags: ["Stress", "Anxiety", "Focus"],
    durationsTags: ["Under 5 Min", "Over 5 Min"],
    destination: BoxBreathing(), 
  ),
  Technique(
    name: "Guided Meditation",
    description: "Follow along meditation session",
    image: "assets/icons/guided_meditation.png",
    tags: ["Guided"],
    strugglesTags: ["Stress", "Anxiety", "Focus", "Anger", "Sadness"],
    durationsTags: ["Over 5 Min"],
    destination: VideoTechnique(videoURL: "https://flow-state-2025.s3.us-east-2.amazonaws.com/guided_meditation.mp4"),
  ),
  Technique(
    name: "Nature Sounds",
    description: "Calming sounds from the rainforest",
    image: "assets/icons/nature_sounds.png",
    tags: ["Auditory"],
    strugglesTags: ["Stress", "Anxiety", "Sadness"],
    durationsTags: ["Under 5 Min", "Over 5 Min"],
    destination: VideoTechnique(videoURL: "https://flow-state-2025.s3.us-east-2.amazonaws.com/nature_sounds.mp4"),
  ),
  Technique(
    name: "Wood Soup",
    description: "Feels like a brain massage",
    image: "assets/icons/wood_soup.png",
    tags: ["Visual", "Auditory"],
    strugglesTags: ["Stress", "Anxiety", "Poor Sleep"],
    durationsTags: ["Under 5 Min", "Over 5 Min"],
    destination: VideoTechnique(videoURL: "https://flow-state-2025.s3.us-east-2.amazonaws.com/wood_soup_hq.mp4"),
  ),
];