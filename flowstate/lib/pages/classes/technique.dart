import '../techniques/binaural_beats.dart';
import '../techniques/box_breathing.dart';
import '../techniques/guided_meditation.dart';
import '../techniques/nature_sounds.dart';
import '../techniques/wood_soup.dart';

class Technique {
  String name;
  String description;
  String image;
  List<String> tags;          
  List<String> strugglesTags;  
  List<String> durationsTags;  

  Technique({
    required this.name,
    required this.description,
    required this.image,
    required this.tags,
    required this.strugglesTags,
    required this.durationsTags,
  });
}

// List of all techniques
List<Technique> allTechniques = [
  Technique(
    name: "Binaural Beats",
    description: "Intense auditory experience",
    image: "assets/icons/binaural_beats.jpg",
    tags: ["Auditory"],
    strugglesTags: ["Stress", "Anxiety", "Focus", "Poor Sleep"],
    durationsTags: ["Under 10 Min", "No Time Limit"],
  ),
  Technique(
    name: "Box Breathing",
    description: "Controlled breathing exercise",
    image: "assets/icons/box_breathing.png",
    tags: ["Visual"],
    strugglesTags: ["Stress", "Anxiety", "Focus"],
    durationsTags: ["Under 10 Min", "No Time Limit"],
  ),
  Technique(
    name: "Guided Meditation",
    description: "Follow along meditation session",
    image: "assets/icons/guided_meditation.png",
    tags: ["Auditory"],
    strugglesTags: ["Stress", "Anxiety", "Focus", "Anger", "Sadness"],
    durationsTags: ["Over 10 Min", "No Time Limit"],
  ),
  Technique(
    name: "Nature Sounds",
    description: "Calming sounds from the rainforest",
    image: "assets/icons/nature_sounds.png",
    tags: ["Visual", "Auditory"],
    strugglesTags: ["Stress", "Anxiety"],
    durationsTags: ["Under 10 Min", "No Time Limit"],
  ),
  Technique(
    name: "Wood Soup",
    description: "Feels like a brain massage",
    image: "assets/icons/wood_soup.png",
    tags: ["Visual", "Auditory"],
    strugglesTags: ["Stress", "Anxiety"],
    durationsTags: ["Under 10 Min", "No Time Limit"],
  ),
];