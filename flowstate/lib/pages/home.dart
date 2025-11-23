import 'package:flutter/material.dart';
import 'classes/technique.dart';
import 'classes/color_manager.dart';
import 'classes/favorite.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Home extends StatefulWidget {
  final String user;
  final List<String> userTags;
  final int? streak;
  final DateTime? userLastLogin;
  final List<String>? favoriteTechniques;
  
  const Home({super.key, required this.user, required this.userTags, required this.streak, required this.userLastLogin, required this.favoriteTechniques});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Technique> finalTechniques = [];
  List<Technique> savedFinalTechniques = [];
  List<Technique> favoriteTechniques = [];
  
  String showingAllText = "";

  var user = Hive.box('Users').getAt(0);
  
  Set<String> getUserTags() {
    return widget.userTags.toSet();
  }

  //default: Meditation View
  int currentView = 0;

  bool showAllTechniques = false;
  bool showFavorites = false;

  void _switchView(int index) {
    setState(() {
      currentView = index;
    });
  }

  //Initialize Techniques
  @override void initState() {
    super.initState();
    changeTechniques();

    //Listens to update user information without having to reload app
    Hive.box('Users').listenable().addListener(() {
      updateFavoriteTechniques();
    });
  }

  //Update User Favorite Techniques
  void updateFavoriteTechniques() {
    favoriteTechniques = [];
    
    if (user.favoriteTechniqueNames != null) {
      for (var technique in allTechniques) {
        if (user.favoriteTechniqueNames.contains(technique.name)) {
          favoriteTechniques.add(technique);
        }
      }
    }
  }

  //Filter Techniques based on User Tags
  void changeTechniques() {
    List<Technique> filteredTechniques = [];
    
    Set<String> userTagsSet = widget.userTags.toSet();

    for (int i=0; i < allTechniques.length; i++) {
      Technique technique = allTechniques[i];

      if(widget.favoriteTechniques!.contains(technique.name)) {
        favoriteTechniques.add(technique);
      }

      bool durationTagMatch = false;
      bool struggleTagMatch = false;
      bool typeTagMatch = false;
      for(var tag in technique.tags) {
        if (userTagsSet.contains(tag)) {
          filteredTechniques.add(technique);
          typeTagMatch = true;
          break;
        }
        
      }

      for(var tag in technique.strugglesTags) {
        if (userTagsSet.contains(tag)) {
          filteredTechniques.add(technique);
          struggleTagMatch = true;
          break;
        }
      }

      for(var tag in technique.durationsTags) {
        if (userTagsSet.contains(tag)) {
          filteredTechniques.add(technique);
          durationTagMatch = true;
          break;
        }
      }

      if(durationTagMatch) {
        if(typeTagMatch) {
          if(struggleTagMatch) {
            finalTechniques.add(technique);
          }
        }
      }
    }

    savedFinalTechniques = finalTechniques;
  }

  //User Options Pop Up
  void _showUserOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 500,
            height: 650,
          )
        );
      }
    );
  }

  //Pop Up Chip
  Widget _showChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Color.lerp(
        ColorManager.secondary,
        ColorManager.primary,
        0.2,
        ),
        border: Border.all(
          color: ColorManager.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold
        )
      )
    );
  }

  //Pop Up Box
  void _showPopUpDescription(Technique technique) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 500,
            height: 650,
            decoration: BoxDecoration(
              color: ColorManager.secondary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          technique.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorManager.primary,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(
                      technique.image,
                      width: 350,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Color.lerp(
                    ColorManager.secondary,
                    ColorManager.primary,
                    0.5,
                  ),
                  thickness: 3,
                  indent: 25,       
                  endIndent: 40,     
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 6,
                        children: [
                          for (String tag in technique.tags)
                          _showChip(tag),
                        ],
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 6,
                        children: [
                          for (String tag in technique.strugglesTags)
                          _showChip(tag),
                        ],
                      ),
                      SizedBox(height: 20),
                      if(technique.durationsTags.length == 2)
                        _showChip('No Time Limit')
                      else
                        _showChip(technique.durationsTags.first)
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Favorite(technique: technique,),          
              ],
            ),
          ),
        );
      },
    );
  }


  //Flow AI View
  Widget _flowAIView() {
    return Center(child: Text('Flow AI'),);
  }

  //Meditation View
  Widget _meditationView() {

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
              
            //Profile Tab
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                padding: EdgeInsets.all(2),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    bottom: BorderSide(
                      color: ColorManager.primary,
                      width: 3.0,
                    )
                  ),
                  color: ColorManager.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(179, 178, 178, 1),
                      offset: Offset(2, 4.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    //Profile Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary, 
                        shape: CircleBorder(),
                      ),
                      onPressed: () {
                        _showUserOptions();
                      },
                      child: Icon(
                        Icons.person_4,
                        size: 25,
                        color: ColorManager.secondary,
                      ),
                    ),
                    
                    //Username
                    Expanded(
                      child: Text(
                        widget.user,
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                      
                    // Streak
                    Row(
                      children: [
                        // Streak 
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color.lerp(
                              ColorManager.secondary,
                              ColorManager.streakColor,
                              0.2,
                            ),
                            border: Border.all(
                              color: ColorManager.streakColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Streak Icon
                              Image.asset(
                                'assets/icons/streak_fire.png',
                                width: 28,
                                height: 36,
                              ),
                              SizedBox(width: 6),
                              // Streak Number
                              Text(
                                widget.streak.toString(),
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: ColorManager.streakColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),         
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
        
            Padding(
              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
              child: Row(
                children: [
                  Text(
                    'Recommended:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: ColorManager.textColor
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    showingAllText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: ColorManager.primary
                    ),
                  ),
                ],
              ),
            ),
        
            SizedBox(height: 5),
        
            //Horizontal Scrollable ListView of Techniques
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: finalTechniques.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => finalTechniques[index].destination,
                        ),
                      );
                    },
                    onLongPress: () {
                      _showPopUpDescription(finalTechniques[index]);
                    },
                    //Technique Card
                    child: Container(
                      width: 400,
                      margin: EdgeInsets.only(left: 6, right: 12),           
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorManager.secondary,
                        border: Border.all(
                          width: 3,
                          color: ColorManager.primary,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(179, 178, 178, 1),
                            offset: Offset(4.2, 6.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //Technique Image
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(9),
                              topRight: Radius.circular(9),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              finalTechniques[index].image,
                              width: 400,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
        
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //Technique Name
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  finalTechniques[index].name.toUpperCase(),
                                  style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: 36,                              
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.1,   
                                  ),
                                  textAlign: TextAlign.center
                                ),
                                SizedBox(height: 8),
                                //Technique Short Description
                                Text(
                                  finalTechniques[index].description,
                                  style: TextStyle(
                                    color: ColorManager.textColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),       
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        
           
            Row(
              children: [
                //Show All Checkbox
                Checkbox(
                  value: showAllTechniques,
                  onChanged:(bool? value) {
                    setState(() {
                     if(showAllTechniques) {
                        showAllTechniques = false;
                      }
                      else {
                        showAllTechniques = true;
                      }
                      showFavorites = false;
                      if(showAllTechniques) {
                        showingAllText = "(showing all)";
                        finalTechniques = allTechniques;
                      } else {
                        showingAllText = "";
                        finalTechniques = savedFinalTechniques;
                      }
                    });
                  },
                  activeColor: ColorManager.primary,
                  side: BorderSide(
                    color: ColorManager.primary,
                    width: 2.0,
                  )
                ),
            
                //Show All Text
                Text(
                  'Show all',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.primary
                  ),
                ),
              
              ],
            ),
            Row(
              children: [
                //Show Favorites Checkbox
                Checkbox(
                  value: showFavorites,
                  onChanged:(bool? value) {
                    setState(() {
                      if(showFavorites) {
                        showFavorites = false;
                      }
                      else {
                        showFavorites = true;
                      }
                      updateFavoriteTechniques();
                      showAllTechniques = false;
                      if(showFavorites) {
                        showingAllText = "(showing favorites)";
                        finalTechniques = favoriteTechniques;
                      } else {
                        showingAllText = "";
                        finalTechniques = savedFinalTechniques;
                      }
                    });
                  },
                  activeColor: ColorManager.primary,
                  side: BorderSide(
                    color: ColorManager.primary,
                    width: 2.0,
                  )
                ),
            
                //Show Favorites Text
                Text(
                  'Show favorites',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.primary
                  ),
                ),
              
              ],
            ),

          ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> views = [
      _meditationView(),
      _flowAIView(),
    ];

    return Scaffold(
      backgroundColor: Color.lerp(
        ColorManager.secondary,
        ColorManager.primary,
        0.07,
      ),
      body: views[currentView],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentView,
        onTap: _switchView,
        backgroundColor: ColorManager.secondary,
        selectedItemColor: ColorManager.primary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Meditation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Flow AI',
          ),
        ],
      ),
    );
  }
}