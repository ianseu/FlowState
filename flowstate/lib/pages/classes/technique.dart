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
  

  Technique({
    required this.name,
    required this.description,
    required this.image,
    required this.tags,
  });
}

// List of all techniques
List<Technique> allTechniques = [
  Technique(
    name: "Binaural Beats",
    description: "Auditory relaxation and focus",
    image: "assets/icons/binaural_beats.jpg",
    tags: ["Auditory", "Stress", "Anxiety", "Focus", "Poor Sleep", "Under 5 Min", "Over 5 Min", "No Time Limit"]
  ),
  Technique(
    name: "Box Breathing",
    description: "Controlled breathing exercise",
    image: "assets/icons/box_breathing.png",
    tags: ["Visual", "Stress", "Anxiety", "Focus", "Under 5 Min", "Over 5 Min",  "No Time Limit"]
  ),
  Technique(
    name: "Guided Meditation",
    description: "Follow along meditation session",
    image: "assets/icons/guided_meditation.png",
    tags: ["Auditory", "Stress", "Anxiety", "Focus", "Anger", "Sadness", "Over 5 Min", "No Time Limit"]
  ),
  Technique(
    name: "Nature Sounds",
    description: "Calming sounds from the rainforest",
    image: "assets/icons/nature_sounds.png",
    tags: ["Visual", "Auditory", "Stress", "Anxiety", "Under 5 Min", "Over 5 Min",  "No Time Limit"]
  ),
  Technique(
    name: "Wood Soup",
    description: "Visual/Audial ASMR",
    image: "assets/icons/wood_soup.png",
    tags: ["Visual", "Auditory", "Stress", "Anxiety", "Under 5 Min", "Over 5 Min",  "No Time Limit"],
  ),
];