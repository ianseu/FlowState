import '../techniques/binaural_beats.dart';
import '../techniques/box_breathing.dart';
import '../techniques/guided_meditation.dart';
import '../techniques/nature_sounds.dart';
import '../techniques/wood_soup.dart';

class Technique {
  String name;
  String description;
  String image;

  Technique({
    required this.name,
    required this.description,
    required this.image,
  });
}

// List of all techniques
List<Technique> allTechniques = [
  Technique(
    name: "Binaural Beats",
    description: "Auditory illusion for deep relaxation",
    image: "assets/icons/binaural_beats.jpg",
  ),
  Technique(
    name: "Box Breathing",
    description: "4-4-4-4 breathing technique",
    image: "assets/icons/box_breathing.png",
  ),
  Technique(
    name: "Guided Meditation",
    description: "Follow along meditation sessions",
    image: "assets/icons/guided_meditation.png",
  ),
  Technique(
    name: "Nature Sounds",
    description: "Calming sounds from nature",
    image: "assets/icons/nature_sounds.png",
  ),
  Technique(
    name: "Wood Soup",
    description: "Your custom description here",
    image: "assets/icons/wood_soup.png",
  ),
];