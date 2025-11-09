import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/user.dart';
import 'home.dart';

//Picking Tags page
class PickTags extends StatefulWidget {
  final String user;
  const PickTags({super.key, required this.user});

  @override
  State<PickTags> createState() => _PickTagsState();
}

class _PickTagsState extends State<PickTags> {

  //Hive storage 'box'
  var box = Hive.box('Users');
  late User currentUser;
  //List of selected tags which will be added to user's profile
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    currentUser = box.get(widget.user);
  }
  
  List<String> typeTags = [
    "Visual",
    "Auditory",
    "Guided",
  ];

  List<String> strugglesTags = [
    "Poor Sleep",
    "Stress",
    "Anxiety",
    "Focus",
    "Anger",
    "Sadness",
  ];

  List<String> durationsTags = [
    "Under 5 Min",
    "Over 5 Min",
    "No Time Limit",
  ];


  //Reusable UI build of a group of tags
  Widget buildTagSection(String title, List<String> tags) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 0, 0, 1)
          ),
        ),
        Wrap(
          spacing: 4,
          alignment: WrapAlignment.center,
          children: [
            //Creates a selectable chip for every tag
            for (String tag in tags)
              FilterChip(
                showCheckmark: false,
                backgroundColor:  Color.fromARGB(255, 255, 255, 255),
                selectedColor: Color.fromRGBO(84, 125, 194, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Color.fromRGBO(84, 125, 194, 1))
                ),
                label: Text(
                  tag,
                  style: TextStyle(
                    color: selectedTags.contains(tag) 
                      //? - if true
                      //: - else
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromRGBO(84, 125, 194, 1),
                  )
                  ),
                selected: selectedTags.contains(tag),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedTags.add(tag);
                    } else {
                      selectedTags.remove(tag);
                    }
                  });
                },
              ),
          ],
        ),
      ],
    );
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanks for joining us, ${widget.user}!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(84, 125, 194, 1)
                ),
              ),

              Text(
                'Please select from the available tags to customize your experience:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1)
                ),
              ),
              SizedBox(height: 40),

              buildTagSection("What type of meditation appeals to you?", typeTags),
              SizedBox(height: 20),

              buildTagSection("Are you struggling with any of the following?", strugglesTags),
              SizedBox(height: 10),

              buildTagSection("How long can you put towards meditation everyday?", durationsTags),
              SizedBox(height: 80),

              SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(84, 125, 194, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500.0),
                    side: BorderSide(color: Color.fromRGBO(84, 125, 194, 1)),
                  ),
                ),
                onPressed: () {
                  currentUser.tags = selectedTags;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home(user: widget.user, userTags: selectedTags)),
                  );
              },
                child: Text(
                'Continue',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
            ],
          ),
        ),   
      ),
    );
  }
}